require('config/mappings/sticky_terminals')
require('config/mappings/diagnostics')
require('config/mappings/vim')
require('config/mappings/ts_textobjects')
require('config/mappings/comments')
require('config/mappings/koala')
require('config/mappings/cmdline')
require('config/mappings/toggle')

-- Available e (only E used), r (only R used), o (only O used), y, f (only ff used)
local api = require("config/api")
local config = require("config/config")

local setv = api.keymap.leader_visual
local set = api.keymap.leader

vim.keymap.set("n", "<leader>,", "ggVG", { desc = "Select entire buffer" })

vim.keymap.set("n", "K", api.help.open, { desc = "Open help under cursor" })
vim.keymap.set("v", "K", function() api.help.open(nil, true) end, { desc = "Open help under cursor" })

-- ll set by ../plugins/smart-open.lua
set("lc", "<cmd>Easypick changed_files<cr>", "List changed files (Easypick)")
set("lf", "<cmd>Easypick new_files<cr>", "List new files (Easypick)")
set("lC", "<cmd>Easypick changed_files_previous_commit<cr>", "List files changed in previous commit")
set("lx", "<cmd>Easypick conflicts<cr>", "List conflicted files")
set("lw", "<cmd>Telescope zoxide list<cr>", "Jump to directory (zoxide)")

set("L", "<cmd>Lazy<cr>", "Open Lazy plugin manager")

-- Recognizes format such as foo.bar:32:10 => open foo.bar line 32 column 10
vim.keymap.set({ "n", "v", "o" }, "gf", "gF", { remap = true, desc = "Open file under cursor (with line:col)" })

set("O", api.file.open_by_first_letter, "Open file under cursor")
set(";", api.file.open_by_extension, "Open file under cursor (guess extension)")
set(".", api.file.open_by_extension, "Open file under cursor (guess extension)")

vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "Show LSP signature help" })

set("A", "<cmd>NodeAction<cr>", "Run node action")

-- Open a new empty buffer in the current window
set("bn", "<cmd>enew<cr>", "New buffer in current window")
set("bh", "<cmd>vsplit<cr>", "Split window vertically")
set("bj", "<cmd>belowright split<cr>", "Split window below")
set("bk", "<cmd>topleft split<cr>", "Split window above")
set("bl", "<cmd>botright vs<cr>", "Split window to the right")
set("bx", api.buffer.close_current, "Close current buffer")
-- Close all buffers but one
set("bX", api.buffer.close_hidden, "Close other buffers in tab")

-- set("T", function()
--   if vim.o.showtabline >= 1 then
--     api.tab.set_hidden(true)
--   else
--     api.tab.set_hidden(false)
--   end
-- end)

set("E", "<cmd>:e!<cr>", "Reload file, discard changes")
set("ss", ":mksession! ~/Session.vim<cr>", "Save session")

-- Close current buffer
set("q", api.window.close_if_not_last, "Close window (unless last)")
-- Close neovim
set("Q", "<cmd>qa!<cr>", "Quit Neovim, discard all changes")
set("R", "<cmd>mksession! /tmp/Session.vim | restart | source /tmp/Session.vim<cr>", "Restart Neovim, restoring session")

set("m", "<cmd>Mason<cr>", "Open Mason")

-- Echo current filede
set("F", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  local relative_path = vim.fn.fnamemodify(bufname, ":.")
  vim.notify(relative_path)
end, "Echo current file path")

set("tu", "<cmd>Telescope undo<cr>", "Open undo history")

set("tb", "<cmd>Telescope bookmarks<cr>", "Open bookmarks")

-- set("ty") by neoclip.lua
set("tt", "<cmd>Telescope<cr>", "Open Telescope picker list")
set("tg", api.telescope.live_grep, "Live grep")

set("wh", api.ast_grep.find_wolverine_handler, "Find Wolverine handler")
set("ws", api.ast_grep.find_wolverine_sender, "Find Wolverine sender")

setv("tg", function()
  local selection_text = api.text.visual_selection()
  require('telescope.builtin').live_grep({ default_text = selection_text })
end, "Live grep selected text")
set("tG", "<cmd>Telescope grep_string<cr>", "Grep word under cursor")
-- Reopen last search (so useful)
set("tr", "<cmd>Telescope resume<cr>", "Resume last Telescope search")
set("tz", "<cmd>Telescope buffers<cr>", "List open buffers")
set("tf", "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy find in current buffer")
setv("tf", function()
  local selection_text = api.text.visual_selection()
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
    set("t" .. api.keymap.azerty_digits[i + 1], "<cmd>" .. tostring(i) .. "tabn" .. "<cr>", "Go to tab " .. tostring(i))
  end

  set("t" .. tostring(i), "<cmd>" .. tostring(i) .. "tabn" .. "<cr>", "Go to tab " .. tostring(i))
end

set("tq", function() require("telescope.builtin").quickfix({
  trim_text = true,
  path_display = { "smart" }
}) end, "Open quickfix list (Telescope)")

set("pn", api.terminal.open_unused_or_create, "Open terminal (reuse unused)")
set("pN", "<cmd>term<cr>", "Open new terminal")
set("ph", "<cmd>vsplit | lua _G.OpenUnusedTermOrCreate()<cr>", "Open terminal in vertical split (left)")
set("pj", "<cmd>belowright split | lua _G.OpenUnusedTermOrCreate()<cr>", "Open terminal in split below")
set("pk", "<cmd>topleft split | lua _G.OpenUnusedTermOrCreate()<cr>", "Open terminal in split above")
set("pl", "<cmd>botright vs | lua _G.OpenUnusedTermOrCreate()<cr>", "Open terminal in vertical split (right)")

-- Repeat last command (very useful)
set("pr", api.terminal.repeat_last_command, "Repeat last terminal command")

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
set("nn", api.file.create_note, "Create new note file")
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

set("zz", api.window.center, "Center window")
set("zc", api.window.close_centered, "Close centered window")
set("zx", api.window.close_centered, "Close centered window")

-- Open the extremely useful quickfix list (enhanced via bqf btw)
set("it", api.dotnet.parse_test_file, "Open quickfix list")
set("io", "<cmd>copen<cr>", "Open quickfix list")
set("ij", "<cmd>cnext<cr>", "Next quickfix item")
set("ik", "<cmd>cprev<cr>", "Previous quickfix item")

set("gl", api.git.pick_modified_hunks, "Git diff (Telescope)")
set("gH", function()
  require("telescope").extensions.git_file_history.git_file_history()
end, "Git file history")
set("ga", function()
  local env = {
    GIT_SEQUENCE_EDITOR=":",
  }
  local opts = { env = env }
  api.job.run({ { "git", "add", "-u" }, { "git", "absorb", "--and-rebase" } }, opts, "absorbing")
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
    vim.cmd("noremap <silent> " .. api.keymap.azerty_digits[i + 1] .. " " .. tostring(i))
    vim.cmd("noremap <silent> " .. tostring(i) .. " " .. api.keymap.azerty_digits[i + 1])
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

set("wj", api.smelly_sunflower.insert_log_below, "Insert debug log below")
set("wk", api.smelly_sunflower.insert_log_above, "Insert debug log above")
set("wc", api.smelly_sunflower.clean_logs, "Remove debug logs")
set("wC", api.smelly_sunflower.clean_all_logs, "Remove debug logs (all buffers)")

set("vs", function()
  local path = vim.fn.expand("%")
  local linenumber = vim.api.nvim_win_get_cursor(0)[1]
  os.execute("code -g " .. path .. ":" .. linenumber)
end, "Open file at line in VS Code")

set("ct", api.dotnet.parse_test_file, "Open quickfix list for test")
set("cr", api.dotnet.rebuild, "Rebuild")
set("cs", api.dotnet.rebuild, "Rebuild")
set("cb", api.dotnet.build, "Build")

set("uu", ":Undotree<cr>")

vim.cmd("autocmd FileType qf map <buffer> dd <tab>zN")

vim.keymap.set("n", "q", function()
  api.ui.toggle_recording_cursor_hl()
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

set("se", function()
  vim.wo[0].nuw = vim.wo[0].nuw
end)
