local utils = require("config/utils")
local M = {}

local sticky_terminals = {}

local function execute_command(cmds, opts, index)
  if index > #cmds then
    return
  end

  M._async_spinner.message = table.concat(cmds[index], " ")

  vim.system(cmds[index], opts, function(obj)
    if obj.code ~= 0 then
      local message = cmds[index] .. " " .. obj.stderr
      vim.notify(message, vim.log.levels.ERROR)
    end

    execute_command(cmds, opts, index + 1)

    if index == #cmds then
      M._async_spinner:finish()
      if obj.code == 0 then
        vim.notify(obj.stdout, vim.log.levels.INFO)
      end
    end
  end)
end

-- Execute given command async, notify user if error
M.execute_async_cmd = function(cmds, opts, title)
  local fidget = require("fidget")
  M._async_spinner = fidget.progress.handle.create({
    title = title,
  })

  execute_command(cmds, opts, 1)
end

M.execute_async_shell_cmd = function(cmd, opts, title)
  M.execute_async_cmd({ { vim.o.shell, vim.o.shellcmdflag, cmd } }, opts, title)
end

-- Close window is it is a floating window or if it not the last opened window in the current tab
M.close_window_if_not_last = function(window)
  window = window or vim.api.nvim_get_current_win()
  local current_win_is_floating = vim.api.nvim_win_get_config(window).relative ~= ""

  if current_win_is_floating then
    vim.cmd("q")
  else
    local windows_in_tab = vim.tbl_filter(function(win)
      local is_valid = vim.api.nvim_win_is_valid(win)
      local buf = vim.api.nvim_win_get_buf(win)
      local loaded = vim.api.nvim_buf_is_loaded(buf)
      local win_is_floating = vim.api.nvim_win_get_config(win).relative ~= ""
      return is_valid and buf and loaded and not win_is_floating
    end, vim.api.nvim_tabpage_list_wins(0))

    if #windows_in_tab > 1 then
      vim.cmd("q")
    end
  end
end

M.close_buffer_if_not_last = function(buffer)
  -- TODO: refactor with win_findbuf
  local window = -1

  for _, win in pairs(vim.api.nvim_list_wins()) do
    local win_buffer = vim.api.nvim_win_get_buf(win)
    if win_buffer == buffer then
      window = win
    end
  end

  if window ~= -1 then
    M.close_window_if_not_last(window)
  end
end

M.create_org_file = function()
  local dirman = require("neorg").modules.get_module("core.dirman")
  local file = vim.fn.input("File : ", "", "file")

  dirman.create_file(file, "notes", {
    no_open = false, -- open file after creation?
    force = false, -- overwrite file if exists
  })
end

-- TODO: make a pull request to the extension
local function open_file(is_extension)
  local history = require("telescope._extensions.smart_open.history")
  local history_result, max_score = history:get_all()
  local matched_history = {}
  local letter = vim.fn.getcharstr()

  if is_extension then
    letter = "%." .. letter
  else
    letter = "^" .. letter
  end

  -- TODO: read how smart_open does it to search faster than a manual loop + regex
  for _, v in ipairs(history_result) do
    if v.exists then
      local frecency = v.score / max_score
      local regex = ".*/(.*)"
      -- If it is not extension then we want first letter

      regex = "^" .. regex

      local _, _, file = string.find(v.path, regex)

      if string.find(file, letter) then
        table.insert(matched_history, { path = v.path, frecency = frecency })
      end
    end
  end

  table.sort(matched_history, function(a, b)
    return a.frecency < b.frecency
  end)

  if matched_history and #matched_history ~= 0 then
    vim.cmd("e " .. matched_history[#matched_history].path)
  end
end

M.open_file_with_extension = function()
  open_file(true)
end

M.open_file = function()
  open_file(false)
end

M.start_insert_if_bottom = function()
  local total_number_of_lines = vim.fn.line("$")
  local current_line = vim.fn.line(".")
  local nb_lines_to_bottom_screen = total_number_of_lines - current_line
  local height = vim.api.nvim_win_get_height(0) + 1

  -- total_number_of_lines < height = new terminal => insert mode when focus
  -- nb_lines_to_bottom_screen < height => cursor close to the bottom => insert mode when focus
  -- else nb_lines_to_bottom_screen >= height => I put my cursor somewhere specific on purpose
  -- => I do not want to lose that line by going insert mode (which scroll to the bottom)
  if total_number_of_lines < height or nb_lines_to_bottom_screen < height then
    vim.cmd("startinsert")
  end
end

M.close_buffer = function()
  if vim.startswith(vim.fn.expand("%"), "term://") then
    -- Closing buffer without closing window
    vim.cmd("bp|sp|bn|bd!")
  else
    -- Closing buffer without closing window
    vim.cmd("bp|sp|bn|bd")
  end
  -- TODO: close buffer without closing tab
end

-- Solution given by Justin himself !
local function terminal_is_available(buffer)
    local is_terminal = vim.bo[buffer].buftype == "terminal"
    if not is_terminal then
      return false
    end

    local channel = vim.bo[buffer].channel
    local child_process = vim.api.nvim_get_proc_children(vim.fn.jobpid(channel))
    local child_process_nb = vim.tbl_count(child_process)

    return child_process_nb == 0
end

M.open_unused_term_or_create = function()
  local buffers = vim.api.nvim_list_bufs()

  for _, buffer in ipairs(buffers) do
    local opened = vim.fn.bufwinnr(buffer) ~= -1

    if not opened and utils.buffer_is_in_tab(buffer) and terminal_is_available(buffer) then
      vim.cmd(":buffer " .. buffer)
      return
    end
  end

  vim.cmd(":term fish")
end

_G.OpenUnusedTermOrCreate = M.open_unused_term_or_create


M.get_visual_selection = function()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

local function get_tab_buffers()
  return vim.tbl_filter(function(b) return vim.fn.buflisted(b) == 1 end,
                        vim.api.nvim_list_bufs())
end

M.close_other_tab_buffers = function()
  local buffers = get_tab_buffers()
  for _, buffer in ipairs(buffers) do
    local open = vim.fn.bufwinnr(buffer) > 0

    if vim.api.nvim_buf_is_valid(buffer) and not open then
      -- TODO: close terminal not active
      if vim.bo[buffer].buftype ~= "terminal" and vim.bo[buffer].modified ~= 1 then
        local _, err = pcall(vim.api.nvim_buf_delete, buffer, {})

        if err then
          vim.notify(err, vim.log.levels.WARN)
        end
      end
    end
  end
end
-- }}}

M.open_help = function(word)
  word = word or vim.fn.expand("<cword>")

  if vim.bo.ft == "cs" then
    local url = "https://learn.microsoft.com/fr-fr/search/?scope=.NET&category=Documentation&terms="
    vim.cmd("!xdg-open " .. url .. word .. " &")
  elseif vim.bo.ft == "c" then
    vim.cmd(string.format('Man %s', word))
  elseif vim.bo.ft == "lua" or vim.bo.ft == "vim" then
    vim.cmd(string.format('help %s', word))
  else
    -- notify error to user
    vim.notify("No help available for this filetype", vim.log.levels.ERROR)
  end
end

local last_lazygit_root = nil

M.toggle_lazygit = function(force_new)
  local on_exit = function()
    vim.cmd("Gitsigns refresh")
    vim.cmd("windo e")
  end

  local root = M.get_cwd()
  if root then
    root = vim.fs.root(root, ".git") or ""
  else
    root = ""
  end
  vim.print(root)

  if last_lazygit_root ~= root then
    sticky_terminals["lazygit"] = nil
    last_lazygit_root = root
  end

  M.toggle_persistent_floating_terminal("lazygit", "cd " .. root .. " && lazygit", nil, force_new, on_exit)()
end

local create_new_persistent_floating_terminal = function(terminal_type, cmd, env, on_exit)
  ---@diagnostic disable-next-line: missing-fields
  sticky_terminals[terminal_type] = require('FTerm'):new({
    ft = "ft_" .. terminal_type,
    cmd = cmd,
    on_exit = on_exit,
    env = env,
    ---@diagnostic disable-next-line: missing-fields
    dimensions = {
        height = 0.95,
        width = 0.95
    },
  })
end

M.toggle_persistent_floating_terminal = function(terminal_type, cmd, not_q, force_new, on_exit, env)
  return function()
    local buffer_terminal

    if force_new then
      sticky_terminals[terminal_type] = nil
    end

    if sticky_terminals[terminal_type] ~= nil then
      buffer_terminal = sticky_terminals[terminal_type]:toggle()
    else
      create_new_persistent_floating_terminal(terminal_type, cmd, env, on_exit)
      buffer_terminal = sticky_terminals[terminal_type]:open()
    end

    if not not_q then
      vim.keymap.set("t", "q", function()
        sticky_terminals[terminal_type]:toggle()
      end, { buf = buffer_terminal.buf })
    end
  end
end

M.kill_sticky_terminal = function(terminal_type)
  -- Not supported yet: https://github.com/numToStr/FTerm.nvim/issues/110
  -- sticky_terminals[terminal_type]:exit()
  sticky_terminals[terminal_type] = nil
end

M.get_cwd = function()
  local path = vim.fn.expand('%:h')

  if path:find("term://") or path:find("oil://") or not vim.fn.filereadable(path) then
    path = vim.fn.getcwd()
  end

  return path
end

return M

