require('config/mappings/sticky_terminals')
require('config/mappings/diagnostics')
require('config/mappings/vim')
require('config/mappings/ts_textobjects')
require('config/mappings/comments')
require('config/mappings/koala')
require('config/mappings/cmdline')
require('config/mappings/toggle')
local cursor_styling = require('config/styling/cursor')

-- Available e (only E used), r (only R used), o (only O used), y, f (only ff used)
local api = require("config/api")
local config = require("config/config")
local ast = require("config/ast")

local mappings_utils = require('config/mappings/utils')
local setv = mappings_utils.setv
local set = mappings_utils.set

vim.keymap.set("n", "<leader>,", "ggVG")

vim.keymap.set("n", "K", api.open_help)

-- ll set by ../plugins/smart-open.lua
set("lc", "<cmd>Easypick changed_files<cr>")
set("lf", "<cmd>Easypick new_files<cr>")
set("lC", "<cmd>Easypick changed_files_previous_commit<cr>")
set("lx", "<cmd>Easypick conflicts<cr>")
set("lw", "<cmd>Telescope zoxide list<cr>")

set("L", "<cmd>Lazy<cr>")

set("O", api.open_file)
set(";", api.open_file_with_extension)
set(".", api.open_file_with_extension)

vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)

set("A", "<cmd>NodeAction<cr>")

-- Open a new window with same file as current buffer
set("bh", "<cmd>vsplit<cr>")
set("bj", "<cmd>belowright split<cr>")
set("bk", "<cmd>topleft split<cr>")
set("bl", "<cmd>botright vs<cr>")
set("bx", api.close_buffer)
-- Close all buffers but one
set("bX", api.close_other_tab_buffers)

-- set("T", function()
--   if vim.o.showtabline >= 1 then
--     utils.set_hide_tab(true)
--   else
--     utils.set_hide_tab(false)
--   end
-- end)

set("E", "<cmd>:e!<cr>")
set("ss", ":mksession! ~/Session.vim<cr>")

-- Close current buffer
set("q", api.close_window_if_not_last)
-- Close neovim
set("Q", "<cmd>qa!<cr>")
set("R", "<cmd>mksession! /tmp/Session.vim | restart source /tmp/Session.vim<cr>")

set("m", "<cmd>Mason<cr>")

-- Echo current filede
set("F", "<cmd>echo @%<cr>")

set("tu", "<cmd>Telescope undo<cr>")

set("tb", "<cmd>Telescope bookmarks<cr>")

-- set("ty") by neoclip.lua
set("tt", "<cmd>Telescope<cr>")
set("tg", "<cmd>Telescope live_grep<cr>")

set("wh", ast.find_wolverine_handler)
set("ws", ast.find_wolverine_sender)

setv("tg", function()
  local selection_text = api.get_visual_selection()
  require('telescope.builtin').live_grep({ default_text = selection_text })
end)
set("tG", "<cmd>Telescope grep_string<cr>")
-- Reopen last search (so useful)
set("tr", "<cmd>Telescope resume<cr>")
set("tz", "<cmd>Telescope buffers<cr>")
set("tf", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
setv("tf", function()
  local selection_text = api.get_visual_selection()
  require('telescope.builtin').current_buffer_fuzzy_find({ default_text = selection_text })
end)
set("tF", function()
  local word = vim.fn.expand('<cword>')
  require('telescope.builtin').current_buffer_fuzzy_find({ default_text = word })
end)
set("ts", "<cmd>Tabby jump_to_tab<cr>")

set("tcl", function()
  require('telescope.builtin').find_files({ cwd = "~/.claude_artifacts" })
end)

set("tcg", function()
  require('telescope.builtin').live_grep({ cwd = "~/.claude_artifacts" })
end)


-- Switch to tab 4 with <leader>t4
for i = 0, 9 do
  if config.keyboard == "fr" then
    set("t" .. mappings_utils.fr[i + 1], "<cmd>" .. tostring(i) .. "tabn" .. "<cr>")
  end

  set("t" .. tostring(i), "<cmd>" .. tostring(i) .. "tabn" .. "<cr>")
end

set("tq", function() require("telescope.builtin").quickfix({
  trim_text = true,
  path_display = { "smart" }
}) end)

set("pn", api.open_unused_term_or_create)
set("pN", "<cmd>term<cr>")
set("ph", "<cmd>vsplit | lua _G.OpenUnusedTermOrCreate()<cr>")
set("pj", "<cmd>belowright split | lua _G.OpenUnusedTermOrCreate()<cr>")
set("pk", "<cmd>topleft split | lua _G.OpenUnusedTermOrCreate()<cr>")
set("pl", "<cmd>botright vs | lua _G.OpenUnusedTermOrCreate()<cr>")

-- Repeat last command (very useful)
set("pr", "<cmd>SendToTerm !!<cr>")
set("ps", "<cmd>SendToTerm<cr>")

-- If you juste do "p" and the text in the clipboard has no newline
-- then it will paste it in the middle of the current line.
-- With these keymaps it will always paste on a new line.
--
-- Paste in the line after the current line
set("pp", "<cmd>put<cr>")
-- Paste in the line before current line
set("pP", "<cmd>put!<cr>")

set("tn", "<cmd>tabnew<cr>")
set("tx", "<cmd>tabclose<cr>")
set("tl", "<cmd>tabnext<cr>")
set("th", "<cmd>tabprevious<cr>")
set("tL", "<cmd>+tabmove<cr>")
set("tH", "<cmd>-tabmove<cr>")

set("nm", "<cmd>e ~/notes/memory.norg<cr>")
set("nM", "<cmd>botright 30vnew ~/notes/memory.norg | set invrelativenumber | set invnumber<cr>")
set("nl", "<cmd>Telescope find_files search_dirs={'~/notes'} follow=true<cr>")
set("ng", "<cmd>Telescope live_grep search_dirs={'~/notes'}<cr>")
set("nn", api.create_org_file)
vim.keymap.set("i", "<A-t>", "<cmd>Minuet virtualtext toggle<cr>")

set("no", "<cmd>Bmessages<cr>")

-- <space><backspace>
set("<BS>", function()
  require("notify").dismiss({pending = true, silent = true})
end)

-- ../plugins/treesitter.lua
-- Only correct the word under the cursor if it's actually misspelled
set("sc", function()
  local cword = vim.fn.expand("<cword>")
  local pos = vim.api.nvim_win_get_cursor(0)
  local bad = vim.fn.spellbadword()
  if bad[1] ~= "" and bad[1] == cword then
    vim.cmd("normal! 1z=")
  else
    vim.api.nvim_win_set_cursor(0, pos)
  end
end)
-- Can't use <leader>sl as it is used by for TS swapping
set("s=", "<cmd>CustomTelescopeSpellSuggest<cr>")
-- Repeat last correction (<leader>sc)
set("sr", "<cmd>spellr<cr>")
-- Good, add to dict
set("sg", "zg")
-- Wrong word, remove from dict
set("sw", "zw")
set("sb", "zw")

set("zz", require("config/center-window").center)
set("zc", require("config/center-window").close)
set("zx", require("config/center-window").close)

-- Open the extremely useful quickfix list (enhanced via bqf btw)
set("io", "<cmd>copen<cr>")
set("ij", "<cmd>cnext<cr>")
set("ik", "<cmd>cprev<cr>")

set("gl", require("config/telescope_git_diff"))
set("gH", function()
  require("telescope").extensions.git_file_history.git_file_history()
end)
set("ga", function()
  local env = {
    GIT_SEQUENCE_EDITOR=":",
  }
  local opts = { env = env }
  api.execute_async_cmd({ { "git", "add", "-u" }, { "git", "absorb", "--and-rebase" } }, opts, "absorbing")
end)
set("gc", ":!glab mr checkout ")

for _, key in ipairs({"<A-h>", "<A-j>", "<A-k>", "<A-l>" }) do
  -- Focus window (e.g: <A-l> focus right window)
  vim.keymap.set({ "t", "n", "i" }, key, "<C-\\><C-N><C-w>" .. key)

  -- Move window
  local upper = string.upper(key)
  vim.keymap.set({ "t", "n", "i" }, upper, "<C-\\><C-N><C-w>" .. upper)
end

if config.keyboard == "fr" then
  for i = 0, 9 do
    -- HACK: use noremap instead of vim.keymap.set as otherwise motions
    -- such as d"j (d3j) does not work
    vim.cmd("noremap <silent> " .. mappings_utils.fr[i + 1] .. " " .. tostring(i))
    vim.cmd("noremap <silent> " .. tostring(i) .. " " .. mappings_utils.fr[i + 1])
  end
end

-- HACK: ugly hack to clear the terminal (can help with lag)
-- XXX: change the value in preferences (set scrollback) as well
vim.keymap.set("t", "<C-q>", "<c-\\><c-n><cmd>set scrollback=1 | sleep 100m | set scrollback=20000<cr>")

-- Move in insert mode with <C-hjkl> (very useful)
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")

local smelly_sunflower = require('config/smelly_sunflower')
set("wj", smelly_sunflower.insert_below)
set("wk", smelly_sunflower.insert_above)
set("wc", smelly_sunflower.clean)
set("wC", smelly_sunflower.clean_all_buffers)

set("vs", function()
  local path = vim.fn.expand("%")
  local linenumber = vim.api.nvim_win_get_cursor(0)[1]
  os.execute("code -g " .. path .. ":" .. linenumber)
end)

for _, symbol in ipairs({ "#", "\"", "3", "c" }) do
  set(symbol .. "R", ":Dotnet lsp restart<cr>")
  set(symbol .. "e", ":Dotnet<cr>")
  set(symbol .. "r", ":Dotnet run<cr>")
  set(symbol .. "b", ":Dotnet build<cr>")
  set(symbol .. "d", ":Dotnet debug<cr>")
  set(symbol .. "t", ":Dotnet testrunner<cr>")
  set(symbol .. "l", ":Dotnet lsp restart<cr>")
end

set("C", ":Rebuild ")

vim.cmd("autocmd FileType qf map <buffer> dd <tab>zN")

vim.keymap.set("n", "q", function()
  cursor_styling.stop_start_macro_event()
  -- Recorder start/stop recording
  vim.fn.feedkeys("∆")
end)

set("xx", "<cmd>Trouble diagnostics toggle<cr>")

if config.keyboard == "fr" then
  vim.cmd("nmap <silent> ù `")
end

vim.cmd([[
  noremap <C--> <C-^>
  " Does not work with every azerty keyboards for some reason
  tmap <C-^> <C-\><C-N><C-^>
]])

-- Don't touch unnamed register when pasting over visual selection
vim.cmd("xnoremap <expr> p 'pgv\"' . v:register . 'y'")

set(":", Snacks.picker.command_history)
