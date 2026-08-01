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

vim.keymap.set("n", "<leader>,", "ggVG", { desc = "Select entire buffer" })

vim.keymap.set("n", "K", api.open_help, { desc = "Open help under cursor" })

-- ll set by ../plugins/smart-open.lua
set("lc", "<cmd>Easypick changed_files<cr>", "List changed files (Easypick)")
set("lf", "<cmd>Easypick new_files<cr>", "List new files (Easypick)")
set("lC", "<cmd>Easypick changed_files_previous_commit<cr>", "List files changed in previous commit")
set("lx", "<cmd>Easypick conflicts<cr>", "List conflicted files")
set("lw", "<cmd>Telescope zoxide list<cr>", "Jump to directory (zoxide)")

set("L", "<cmd>Lazy<cr>", "Open Lazy plugin manager")

-- Recognizes format such as foo.bar:32:10 => open foo.bar line 32 column 10
vim.keymap.set({ "n", "v", "o" }, "gf", "gF", { remap = true, desc = "Open file under cursor (with line:col)" })

set("O", api.open_file, "Open file under cursor")
set(";", api.open_file_with_extension, "Open file under cursor (guess extension)")
set(".", api.open_file_with_extension, "Open file under cursor (guess extension)")

vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "Show LSP signature help" })

set("A", "<cmd>NodeAction<cr>", "Run node action")

-- Open a new window with same file as current buffer
set("bh", "<cmd>vsplit<cr>", "Split window vertically")
set("bj", "<cmd>belowright split<cr>", "Split window below")
set("bk", "<cmd>topleft split<cr>", "Split window above")
set("bl", "<cmd>botright vs<cr>", "Split window to the right")
set("bx", api.close_buffer, "Close current buffer")
-- Close all buffers but one
set("bX", api.close_other_tab_buffers, "Close other buffers in tab")

-- set("T", function()
--   if vim.o.showtabline >= 1 then
--     utils.set_hide_tab(true)
--   else
--     utils.set_hide_tab(false)
--   end
-- end)

set("E", "<cmd>:e!<cr>", "Reload file, discard changes")
set("ss", ":mksession! ~/Session.vim<cr>", "Save session")

-- Close current buffer
set("q", api.close_window_if_not_last, "Close window (unless last)")
-- Close neovim
set("Q", "<cmd>qa!<cr>", "Quit Neovim, discard all changes")
set("R", "<cmd>mksession! /tmp/Session.vim | restart source /tmp/Session.vim<cr>", "Restart Neovim, restoring session")

set("m", "<cmd>Mason<cr>", "Open Mason")

-- Echo current filede
set("F", "<cmd>echo @%<cr>", "Echo current file path")

set("tu", "<cmd>Telescope undo<cr>", "Open undo history")

set("tb", "<cmd>Telescope bookmarks<cr>", "Open bookmarks")

-- set("ty") by neoclip.lua
set("tt", "<cmd>Telescope<cr>", "Open Telescope picker list")
set("tg", "<cmd>Telescope live_grep<cr>", "Live grep")

set("wh", ast.find_wolverine_handler, "Find Wolverine handler")
set("ws", ast.find_wolverine_sender, "Find Wolverine sender")

setv("tg", function()
  local selection_text = api.get_visual_selection()
  require('telescope.builtin').live_grep({ default_text = selection_text })
end, "Live grep selected text")
set("tG", "<cmd>Telescope grep_string<cr>", "Grep word under cursor")
-- Reopen last search (so useful)
set("tr", "<cmd>Telescope resume<cr>", "Resume last Telescope search")
set("tz", "<cmd>Telescope buffers<cr>", "List open buffers")
set("tf", "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy find in current buffer")
setv("tf", function()
  local selection_text = api.get_visual_selection()
  require('telescope.builtin').current_buffer_fuzzy_find({ default_text = selection_text })
end, "Fuzzy find selected text in buffer")
set("tF", function()
  local word = vim.fn.expand('<cword>')
  require('telescope.builtin').current_buffer_fuzzy_find({ default_text = word })
end, "Fuzzy find word under cursor in buffer")
set("ts", "<cmd>Tabby jump_to_tab<cr>", "Jump to tab")

set("tcl", function()
  require('telescope.builtin').find_files({ cwd = "~/.claude_artifacts" })
end, "Find files in ~/.claude_artifacts")

set("tcg", function()
  require('telescope.builtin').live_grep({ cwd = "~/.claude_artifacts" })
end, "Grep in ~/.claude_artifacts")


-- Switch to tab 4 with <leader>t4
for i = 0, 9 do
  if config.keyboard == "fr" then
    set("t" .. mappings_utils.fr[i + 1], "<cmd>" .. tostring(i) .. "tabn" .. "<cr>", "Go to tab " .. tostring(i))
  end

  set("t" .. tostring(i), "<cmd>" .. tostring(i) .. "tabn" .. "<cr>", "Go to tab " .. tostring(i))
end

set("tq", function() require("telescope.builtin").quickfix({
  trim_text = true,
  path_display = { "smart" }
}) end, "Open quickfix list (Telescope)")

set("pn", api.open_unused_term_or_create, "Open terminal (reuse unused)")
set("pN", "<cmd>term<cr>", "Open new terminal")
set("ph", "<cmd>vsplit | lua _G.OpenUnusedTermOrCreate()<cr>", "Open terminal in vertical split (left)")
set("pj", "<cmd>belowright split | lua _G.OpenUnusedTermOrCreate()<cr>", "Open terminal in split below")
set("pk", "<cmd>topleft split | lua _G.OpenUnusedTermOrCreate()<cr>", "Open terminal in split above")
set("pl", "<cmd>botright vs | lua _G.OpenUnusedTermOrCreate()<cr>", "Open terminal in vertical split (right)")

-- Repeat last command (very useful)
set("pr", "<cmd>SendToTerm !!<cr>", "Repeat last terminal command")
set("ps", "<cmd>SendToTerm<cr>", "Send line/selection to terminal")

-- If you juste do "p" and the text in the clipboard has no newline
-- then it will paste it in the middle of the current line.
-- With these keymaps it will always paste on a new line.
--
-- Paste in the line after the current line
set("pp", "<cmd>put<cr>", "Paste on new line below")
-- Paste in the line before current line
set("pP", "<cmd>put!<cr>", "Paste on new line above")

set("tn", "<cmd>tabnew<cr>", "Open new tab")
set("tx", "<cmd>tabclose<cr>", "Close tab")
set("tl", "<cmd>tabnext<cr>", "Go to next tab")
set("th", "<cmd>tabprevious<cr>", "Go to previous tab")
set("tL", "<cmd>+tabmove<cr>", "Move tab right")
set("tH", "<cmd>-tabmove<cr>", "Move tab left")

set("nm", "<cmd>e ~/notes/memory.norg<cr>", "Open memory notes")
set("nM", "<cmd>botright 30vnew ~/notes/memory.norg | set invrelativenumber | set invnumber<cr>", "Open memory notes in side split")
set("nl", "<cmd>Telescope find_files search_dirs={'~/notes'} follow=true<cr>", "Find files in notes")
set("ng", "<cmd>Telescope live_grep search_dirs={'~/notes'}<cr>", "Grep in notes")
set("nn", api.create_org_file, "Create new note file")
vim.keymap.set("i", "<A-t>", "<cmd>Minuet virtualtext toggle<cr>", { desc = "Toggle Minuet AI virtual text" })

set("no", "<cmd>Bmessages<cr>", "Open messages log")

-- <space><backspace>
set("<BS>", function()
  require("notify").dismiss({pending = true, silent = true})
end, "Dismiss notifications")

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
end, "Correct misspelled word under cursor")
-- Can't use <leader>sl as it is used by for TS swapping
set("s=", "<cmd>CustomTelescopeSpellSuggest<cr>", "Spelling suggestions")
-- Repeat last correction (<leader>sc)
set("sr", "<cmd>spellr<cr>", "Repeat last spelling correction")
-- Good, add to dict
set("sg", "zg", "Add word to dictionary")
-- Wrong word, remove from dict
set("sw", "zw", "Remove word from dictionary")
set("sb", "zw", "Remove word from dictionary")

set("zz", require("config/center-window").center, "Center window")
set("zc", require("config/center-window").close, "Close centered window")
set("zx", require("config/center-window").close, "Close centered window")

-- Open the extremely useful quickfix list (enhanced via bqf btw)
set("io", "<cmd>copen<cr>", "Open quickfix list")
set("ij", "<cmd>cnext<cr>", "Next quickfix item")
set("ik", "<cmd>cprev<cr>", "Previous quickfix item")

set("gl", require("config/telescope_git_diff"), "Git diff (Telescope)")
set("gH", function()
  require("telescope").extensions.git_file_history.git_file_history()
end, "Git file history")
set("ga", function()
  local env = {
    GIT_SEQUENCE_EDITOR=":",
  }
  local opts = { env = env }
  api.execute_async_cmd({ { "git", "add", "-u" }, { "git", "absorb", "--and-rebase" } }, opts, "absorbing")
end, "Git absorb staged changes")
set("gc", ":!glab mr checkout ", "Checkout merge request (glab)")

for _, key in ipairs({"<A-h>", "<A-j>", "<A-k>", "<A-l>" }) do
  -- Focus window (e.g: <A-l> focus right window)
  vim.keymap.set({ "t", "n", "i" }, key, "<C-\\><C-N><C-w>" .. key, { desc = "Focus window (" .. key .. ")" })

  -- Move window
  local upper = string.upper(key)
  vim.keymap.set({ "t", "n", "i" }, upper, "<C-\\><C-N><C-w>" .. upper, { desc = "Move window (" .. upper .. ")" })
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
vim.keymap.set("t", "<C-q>", "<c-\\><c-n><cmd>set scrollback=1 | sleep 100m | set scrollback=20000<cr>", { desc = "Clear terminal scrollback" })

-- Move in insert mode with <C-hjkl> (very useful)
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })

local smelly_sunflower = require('config/smelly_sunflower')
set("wj", smelly_sunflower.insert_below, "Insert debug log below")
set("wk", smelly_sunflower.insert_above, "Insert debug log above")
set("wc", smelly_sunflower.clean, "Remove debug logs")
set("wC", smelly_sunflower.clean_all_buffers, "Remove debug logs (all buffers)")

set("vs", function()
  local path = vim.fn.expand("%")
  local linenumber = vim.api.nvim_win_get_cursor(0)[1]
  os.execute("code -g " .. path .. ":" .. linenumber)
end, "Open file at line in VS Code")

for _, symbol in ipairs({ "#", "\"", "3", "c" }) do
  set(symbol .. "R", ":Dotnet lsp restart<cr>", "Restart .NET LSP")
  set(symbol .. "e", ":Dotnet<cr>", "Open .NET commands")
  set(symbol .. "r", ":Dotnet run<cr>", "Run .NET project")
  set(symbol .. "b", ":Dotnet build<cr>", "Build .NET project")
  set(symbol .. "d", ":Dotnet debug<cr>", "Debug .NET project")
  set(symbol .. "t", ":Dotnet testrunner<cr>", "Run .NET tests")
  set(symbol .. "l", ":Dotnet lsp restart<cr>", "Restart .NET LSP")
end

set("C", ":Rebuild ", "Rebuild")

set("uu", ":Undotree<cr>")

vim.cmd("autocmd FileType qf map <buffer> dd <tab>zN")

vim.keymap.set("n", "q", function()
  cursor_styling.stop_start_macro_event()
  -- Recorder start/stop recording
  vim.fn.feedkeys("∆")
end, { desc = "Start/stop macro recording" })

set("xx", "<cmd>Trouble diagnostics toggle<cr>", "Toggle diagnostics list (Trouble)")

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

set(":", Snacks.picker.command_history, "Command history")
