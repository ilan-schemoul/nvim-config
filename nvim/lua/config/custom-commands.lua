local utils = require("config/utils")
  local fidget = require("fidget")
local M = {}

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
  M._async_spinner = fidget.progress.handle.create({
    title = title,
  })

  execute_command(cmds, opts, 1)
end

M.execute_async_shell_cmd = function(cmd, opts, title)
  M.execute_async_cmd({ { vim.o.shell, vim.o.shellcmdflag, cmd } }, opts, title)
end

-- Absolute number if not focus
vim.api.nvim_create_autocmd({ "WinEnter" }, {
  callback = function()
    -- Normal buffer (not terminal etc.)
    if vim.wo[0].number then
      vim.wo[0].relativenumber = true
    end
  end,
})

-- Absolute number if not focus
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  callback = function()
    -- Normal buffer (not terminal etc.)
    if vim.wo[0].number then
      vim.wo[0].relativenumber = false
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function(args)
    local buf = vim.api.nvim_win_get_buf(0)

    if vim.bo[buf].readonly then
      vim.notify("Cannot save this file. Try :SudaWrite", vim.log.levels.ERROR)
    end
  end,
})

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

-- Close buffer if the terminal is closed
vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      if (vim.bo.buftype == "terminal" or vim.bo.filetype == "lua") and vim.v.shell_error == 0 then
        vim.cmd("bdelete! " .. vim.fn.expand("<abuf>"))
      end
    end)
  end,
})

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

local function enable_venn_silent()
  vim.cmd([[setlocal ve=all]])
  vim.cmd([[setlocal noai]])

  -- draw a line on HJKL keystokes
  vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
  vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
  vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
  vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
  -- draw a box by pressing "f" with visual selection
  vim.api.nvim_buf_set_keymap(0, "v", "b", ":VBox<CR>", { noremap = true })

  vim.b.venn_enabled = true
end

local function enable_venn()
  vim.notify("Enabled")

  enable_venn_silent()
end

local function disable_venn()
  vim.notify("Disabled")

  vim.cmd([[setlocal ve=]])
  vim.cmd([[setlocal ai]])
  vim.api.nvim_buf_del_keymap(0, "n", "J")
  vim.api.nvim_buf_del_keymap(0, "n", "K")
  vim.api.nvim_buf_del_keymap(0, "n", "L")
  vim.api.nvim_buf_del_keymap(0, "n", "H")
  vim.api.nvim_buf_del_keymap(0, "v", "b")

  vim.b.venn_enabled = nil
end

M.toggle_venn = function()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)

  if venn_enabled == "nil" then
    enable_venn()
  else
    disable_venn()
  end
end

-- vim.api.nvim_create_autocmd({ "FileType", }, {
--     pattern = "norg",
-- callback = enable_venn_silent,
-- })

vim.api.nvim_create_user_command("CopyPath", function()
  vim.cmd("let @+ = expand('%')")
end, { nargs = 0 })

vim.api.nvim_create_user_command("CopyPathWithLine", function()
  vim.cmd("let @+ = expand('%') .. ':' .. line('.')")
end, { nargs = 0 })

vim.api.nvim_create_user_command("OpenSession", function(args)
  if #args.fargs == 1 then
    vim.cmd("source " .. args.fargs[1])
  else
    if vim.fn.file_readable("./Session.vim") then
      vim.cmd("source ./Session.vim")
    else
      vim.cmd("source ~/Session.vim")
    end
  end
end, { nargs = '?' })

vim.api.nvim_create_user_command("Restart", function()
  local restart_exit_code = 22
  vim.cmd("cquit " .. restart_exit_code)
end, { nargs = 0 })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.jpg", "*.png" },
  callback = function()
    vim.cmd("setfiletype img")
  end,
})

vim.api.nvim_create_user_command("H", function(args)
  local arg = args.fargs[1]
  vim.cmd("helpg " .. arg)
  require("telescope.builtin").quickfix()
end, { nargs = '+' })

-- Used by lazygit
vim.api.nvim_create_user_command("FromFTToTab", function(args)
  local name = args.fargs[1]

  if name then
    local line = 1

    if #args.fargs == 2 then
      line = args.fargs[2]
    end

    -- Close the popup with lazygit so I can see the opened file
    if vim.bo.filetype == "lazygit" then
      vim.cmd("q")
    end

    -- Once the popup is closed "e" will open the file outside the popup
    vim.cmd("e +" .. line .. " " .. name)
  end
end, { nargs = '+' })

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

return M
