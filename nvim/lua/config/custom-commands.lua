vim.cmd("command TeeSave :w !sudo tee %")

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function(args)
    buf = vim.api.nvim_win_get_buf(0)

    if vim.bo[buf].readonly then
      vim.notify("Cannot save. Use :TeeSave.", "warn")
    end
  end,
})

local function send_to_term(cmd_text)
  if not cmd_text then
    return
  end

  local function get_first_terminal()
    local terminal_chans = {}
    for _, chan in pairs(vim.api.nvim_list_chans()) do
      if chan["mode"] == "terminal" and chan["pty"] ~= "" then
        table.insert(terminal_chans, chan)
      end
    end

    if #terminal_chans == 0 then
      return nil
    end

    terminal_chans = vim.tbl_filter(function(chan)
      return vim.fn.getbufinfo(chan["buffer"])[1].hidden == 0
    end, terminal_chans)

    table.sort(terminal_chans, function(left, right)
      return left["buffer"] < right["buffer"]
    end)

    return terminal_chans[1]["id"]
  end

  local send_to_terminal = function(terminal_chan, term_cmd_text)
    vim.api.nvim_chan_send(terminal_chan, term_cmd_text .. "\n")
  end

  local terminal = get_first_terminal()

  if not terminal then
    vim.cmd("term")
    terminal = get_first_terminal()
  end

  send_to_terminal(terminal, cmd_text)
end

vim.api.nvim_create_user_command("SendToTerm", function(args)
  if #args.args ~= 0 then
    send_to_term(args.args)
  else
    vim.ui.input({
      prompt = "SendToTerm"
    }, send_to_term)
  end
end, { nargs = "?" })

vim.api.nvim_create_user_command("AddPlugin", function(args)
  local full_name = args.fargs[1]

  local _, _, _, file_name = string.find(full_name, "(.*)/(.*)")
  file_name = file_name:gsub('.nvim', '')

  vim.cmd("edit ~/.config/nvim/lua/plugins/" .. file_name .. ".lua")

  local lines = {
    "return {",
    "  \"" .. full_name .. "\",",
    "  opts = {},",
    "}",
  }

  local id = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_set_lines(id, 0, 0, false, lines)
  vim.cmd("write")
  vim.api.nvim_win_set_cursor(0, { 3, 10 })
  -- vim.cmd("Lazy")
end, { nargs = 1 })

-- Close window is it is a floating window or if it not the last opened window in the current tab
function _G.CloseWindowIfNotLast()
  local current_win_is_floating = vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()).relative ~= ''

  if current_win_is_floating then
    vim.cmd("q")
  else
    local windows_in_tab = vim.tbl_filter(function(win)
      local is_valid = vim.api.nvim_win_is_valid(win)
      local buf = vim.api.nvim_win_get_buf(win)
      local loaded = vim.api.nvim_buf_is_loaded(buf)
      local win_is_floating = vim.api.nvim_win_get_config(win).relative ~= ''
      return is_valid and buf and loaded and not win_is_floating
    end, vim.api.nvim_tabpage_list_wins(0))

    if #windows_in_tab > 1 then
      vim.cmd("q")
    end
  end
end

function _G.create_org_file()
  local dirman = require('neorg').modules.get_module("core.dirman")
  local file = vim.fn.input("File : ", "", "file")

  dirman.create_file(file, "notes", {
    no_open = false,    -- open file after creation?
    force   = false,    -- overwrite file if exists
  })
end

local history = require("telescope._extensions.smart_open.history")

local function open_file(is_extension)
  local history_result, max_score = history:get_all()
  local matched_history = {}
  local letter = vim.fn.getcharstr()

  if is_extension then
    letter = "%." .. letter
  else
    letter = "^" .. letter
  end

  for _, v in ipairs(history_result) do
    if v.exists then
      local frecency = v.score / max_score
      local regex =  ".*/(.*)"
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

function _G.OpenFileWithExtension()
  open_file(true)
end

function _G.OpenFile()
  open_file(false)
end

function _G.StartInsertIfBottom()
  local total_number_of_lines = vim.fn.line("$")
  local current_line = vim.fn.line(".")

  if total_number_of_lines - current_line < 50 then
    vim.cmd("startinsert")
  end
end

function _G.CloseBuffer()
  if vim.startswith(vim.fn.expand("%"), "term://") then
    -- Closing buffer without closing window
    vim.cmd("bp|sp|bn|bd!")
  else
    -- Closing buffer without closing window
    vim.cmd("bp|sp|bn|bd")
  end
end

vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*',
  callback = function()
    vim.schedule(function()
      if (vim.bo.buftype == 'terminal' or vim.bo.filetype == "lua") and vim.v.shell_error == 0 then
        vim.cmd('bdelete! ' .. vim.fn.expand('<abuf>'))
      end
    end)
  end,
})

function _G.OpenUnusedTermOrCreate()
  -- Get local buffers ? How
  local buffers = vim.api.nvim_list_bufs()

  for _, buffer in ipairs(buffers) do
    local opened = vim.fn.bufwinnr(buffer) ~= -1
    local is_terminal = vim.bo[buffer].buftype == "terminal"
    -- NOTE: Fish set the term title to the current directory
    -- If it not the current directory then it is probably not fish
    local is_running = is_terminal and vim.fn.isdirectory(vim.fn.expand(vim.b[buffer].term_title)) == 0

    -- If we find a terminal not currently visible in the current tab reuse it
    if is_terminal and not opened and not is_running then
      vim.cmd(":buffer " .. buffer)
      return
    end
  end

  vim.cmd(":term")
end

local function enable_venn_silent()
  vim.cmd[[setlocal ve=all]]
  vim.cmd[[setlocal noai]]

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

  vim.cmd[[setlocal ve=]]
  vim.cmd[[setlocal ai]]
  vim.api.nvim_buf_del_keymap(0, "n", "J")
  vim.api.nvim_buf_del_keymap(0, "n", "K")
  vim.api.nvim_buf_del_keymap(0, "n", "L")
  vim.api.nvim_buf_del_keymap(0, "n", "H")
  vim.api.nvim_buf_del_keymap(0, "v", "b")

  vim.b.venn_enabled = nil
end

function _G.Toggle_venn()
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

vim.api.nvim_create_user_command("OpenSession", function()
  if vim.fn.file_readable("./Session.vim") then
    vim.cmd("source ./Session.vim")
  else
    vim.cmd("source ~/Session.vim")
  end
end, { nargs = 0 })
