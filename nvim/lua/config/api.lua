local utils = require("config/utils")
local M = {}

M.sticky_terminals = {}

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

  vim.cmd(":term")
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
    ---@diagnostic disable-next-line: param-type-mismatch
    local ok = pcall(vim.cmd, string.format('help %s', word))
    if not ok then
      vim.cmd(string.format('helpg %s', word))
    end
  else
    -- notify error to user
    vim.notify("No help available for this filetype", vim.log.levels.ERROR)
  end
end

local last_lazygit_root = nil

local refresh_buffer = function()
  if vim.api.nvim_buf_get_name(0) ~= "" then
    vim.cmd("Gitsigns refresh")
    vim.cmd("windo e")
  end
end

local get_lazygit_cwd = function(root)
  root = root or M.get_cwd()

  if not root then
    root = last_lazygit_root
  else
    root = vim.uv.fs_realpath(root) or root

    if not root then
      return last_lazygit_root
    else
      return vim.fs.root(root, ".git") or last_lazygit_root
    end
  end
end

M.toggle_lazygit = function(force_new, cwd)
  local on_exit = function()
      vim.schedule(function()
        pcall(refresh_buffer)
      end)
  end

  local root = cwd or get_lazygit_cwd()

  if last_lazygit_root ~= root then
    last_lazygit_root = root
    force_new = true
  end

  local opts = {
    force_new = force_new,
    on_exit = on_exit,
    border = 'rounded',
    dimensions = {
      height = 1,
      width = 1,
    }
  }

  local cmd = { "lazygit" }

  if root then
    table.insert(cmd, "--path")
    table.insert(cmd, root)
  end

  M.toggle_or_create_sticky_term("lazygit", cmd, opts)
end

local create_sticky_term = function(terminal_type, cmd, opts)
  opts.env = opts.env or {}
  opts.env.IS_FTERM = "1"

  ---@diagnostic disable-next-line: missing-fields
  M.sticky_terminals[terminal_type] = require('FTerm'):new({
    ft = opts.ft or ("ft_" .. terminal_type),
    cmd = cmd,
    on_exit = opts.on_exit,
    ---@diagnostic disable-next-line: missing-fields
    dimensions = opts.dimensions or {
        height = 0.95,
        width = 0.95
    },
    env = opts.env,
    border = opts.border,
    z_index = 50,
  })
end

local _toggle_or_create_sticky_term = function(terminal_type, cmd, opts)
  local buffer_terminal

  if M.sticky_terminals[terminal_type] ~= nil and not opts.force_new then
    buffer_terminal = M.sticky_terminals[terminal_type]:toggle()
  else
    create_sticky_term(terminal_type, cmd, opts)
    buffer_terminal = M.sticky_terminals[terminal_type]:open()
  end

  vim.keymap.set("t", "<A-q>", function()
    M.sticky_terminals[terminal_type]:toggle()
  end, { buffer = buffer_terminal.buf, desc = "Toggle " .. terminal_type .. " terminal" })
end

---@param opts? { q?: boolean, force_new?: boolean, on_exit?: function }
M.toggle_or_create_sticky_term = function(terminal_type, cmd, opts)
  opts = opts or {}

  local old_term = M.sticky_terminals[terminal_type]

  if opts.force_new and old_term then
    -- XXX: buggy as hell. I spent a very long time debugging this s*** and
    -- well nvim is buggy or IDK. But stopping a job randomly kills unrelated
    -- jobs (like my shell running inside nvim). Adding a defer_fn to terminal
    -- creation avoid being killed.
    old_term:exit()
  end

  _toggle_or_create_sticky_term(terminal_type, cmd, opts)
end

M.force_new_sticky_term = function(terminal_type, cmd, opts)
  opts = opts or {}
  opts.force_new = true

  return M.toggle_or_create_sticky_term(terminal_type, cmd, opts)
end

-- One sticky fish terminal per cwd, cd'd into it via PRIO_HOME_DIR_STARTUP (see fish config.fish)
M.toggle_or_create_fish_in_cwd = function(cwd)
  -- used in ft, we cannot use paths (:/ etc.) so we hash it
  local cwd_hash = cwd and vim.fn.sha256(cwd)
  local terminal_type = "fish_" .. (cwd_hash or "default")
  local env = { PRIO_HOME_DIR_STARTUP = cwd }

  M.toggle_or_create_sticky_term(terminal_type, { "fish" }, {
    env = env,
    ft = 'ft_fish',
    dimensions = {
        height = 0.8,
        width = 0.6
    },
  })
end

M.kill_sticky_terminal = function(terminal_type)
  -- Not supported yet: https://github.com/numToStr/FTerm.nvim/issues/110
  M.sticky_terminals[terminal_type]:exit()
  M.sticky_terminals[terminal_type] = nil
end

M.toggle_existing_sticky_term = function(terminal_type)
  if not M.sticky_terminals[terminal_type] then
    vim.notify('Sticky terminal does not exist', vim.log.levels.ERROR)
    return
  end

  M.sticky_terminals[terminal_type]:toggle()
end

M.get_cwd = function()
  local path = vim.fn.expand('%:p:h')

  if path:find("://") then
    local _, j = path:find("://")
    path = path:sub(j + 1, path:len())
    local i, _ = path:find("//")
    -- For terminals
    if i then
      path = path:sub(1, i - 1)
    end
  end

  return vim.fn.glob(path) or path
end

return M

