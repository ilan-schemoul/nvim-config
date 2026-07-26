-- NOTE: nvim-various-textobjs adds many text objects
-- https://github.com/chrisgrieser/nvim-various-textobjs?tab=readme-ov-file#list-of-text-objects
-- NOTE: Many mappings defined inside plugins (grep "keys =" to find those)

-- Available e (only E used), r (only R used), o (only O used), y, k (only ko used), f (only ff used)

local api = require("config/api")
local utils = require("config/utils")
local config = require("config/config")

local fr = { "à", "&", "é", "\"", "'", "(", "-", "è", "_", "ç" }

local function set(keys, cmd)

  vim.keymap.set("n", "<leader>" .. keys, cmd, { unique = true })
end

local function setv(keys, cmd)
  vim.keymap.set("v", "<leader>" .. keys, cmd, { unique = true })
end

local diagnostic_goto = function(next, severity)
  local count = next and 1 or -1
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = count, severity = severity })
  end
end

for _, key in ipairs({ ")", "]" }) do
  vim.keymap.set("n", key .. "d", diagnostic_goto(true))
  vim.keymap.set("n", key .. "e", diagnostic_goto(true, "ERROR"))
  vim.keymap.set("n", key .. "w", diagnostic_goto(true, "WARN"))
end

for _, key in ipairs({ "(", "[" }) do
  vim.keymap.set("n", key .. "d", diagnostic_goto(false))
  vim.keymap.set("n", key .. "e", diagnostic_goto(false, "ERROR"))
  vim.keymap.set("n", key .. "w", diagnostic_goto(false, "WARN"))
end

vim.keymap.set("n", "<leader>,", "ggVG")

vim.keymap.set("n", "K", api.open_help)

set("lD", function() vim.diagnostic.open_float({ source = true }) end)
set("lh", vim.lsp.buf.hover)
set("li", "<cmd>Telescope lsp_references<cr>")
set("lI", vim.lsp.buf.implementation)
set("ld", "<cmd>Telescope lsp_definitions<cr>")
set("lb", function() require("telescope.builtin").diagnostics({ sort_by="severity" }) end)
set("ls", "<cmd>Telescope lsp_workspace_symbols<cr>")
set("lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
set("ln", function()
  vim.lsp.buf.rename()
  vim.cmd('silent! wa')
end)
set("la", vim.lsp.buf.code_action)
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

set("N", function()
  if vim.wo[0].statuscolumn ~= "%l" then
    vim.wo[0].statuscolumn = "%l"
    vim.wo[0].number = true
    vim.wo[0].relativenumber = true
  else
    require("config/utils").setup_separators()
    vim.wo[0].number = false
    vim.wo[0].relativenumber = false
  end
end)
set("S", function()
  if vim.wo[0].statuscolumn == utils.separator_char then
    vim.wo[0].statuscolumn = ""
    vim.wo[0].number = false
    vim.wo[0].relativenumber = false
  else
    vim.wo[0].statuscolumn = utils.separator_char
  end
end)
set("T", function()
  if vim.o.showtabline >= 1 then
    utils.set_hide_tab(true)
  else
    utils.set_hide_tab(false)
  end
end)

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

set("u", "<cmd>Telescope undo<cr>")

-- set("ty") by neoclip.lua
set("tt", "<cmd>Telescope<cr>")
set("tg", "<cmd>Telescope live_grep<cr>")
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

-- Switch to tab 4 with <leader>t4
for i = 0, 9 do
  if config.keyboard == "fr" then
    set("t" .. fr[i + 1], "<cmd>" .. tostring(i) .. "tabn" .. "<cr>")
  end

  set("t" .. tostring(i), "<cmd>" .. tostring(i) .. "tabn" .. "<cr>")
end

set("tq", function() require("telescope.builtin").quickfix({
  trim_text = true,
  path_display = { "smart" }
}) end)

set("pn", api.open_unused_term_or_create)
set("pN", "<cmd>term fish<cr>")
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

set("vp", "<cmd>next ~/.config/nvim/lua/plugins<cr>")
set("vw", "<cmd>tcd ~/.config/nvim<cr>")
set("vm", "<cmd>next ~/.config/nvim/lua/config/mappings.lua<cr>")
set("vg", "<cmd>Telescope live_grep search_dirs=~/.config/nvim<cr>")
set("va", "<cmd>next ~/.config/nvim/lua/config/api.lua<cr>")
set("vl", "<cmd>Telescope find_files search_dirs=~/.config/nvim<cr>")
set("vt", "<cmd>e ~/nvim-main/todo.norg<cr>")
set("vv", "<cmd>mapclear | source ~/.config/nvim/init.lua<cr>")

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

-- {{{ Floating terminals
set("go", api.toggle_lazygit)

local pg_cmd = { "pgcli", "postgresql://postgres:p4ssw0rd@localhost:5435/local-liquid" }
set("op", api.toggle_persistent_floating_terminal("pgcli", pg_cmd))

set("ol", api.toggle_persistent_floating_terminal("alogs", { "fish", "-c", "alogs" }))
-- dotnet watch --project /Users/ilan/code/liquid-server/src/AppHost/AppHost.csproj works too
set("oa", api.toggle_persistent_floating_terminal("aspire", { "aspire", "run" }))
set("oc", api.toggle_persistent_floating_terminal("calc", { "calc" }))
set("ot", function()
    local env = { cwd = api.get_cwd() }
    api.toggle_persistent_floating_terminal("fish", "cd /tmp && fish", { env = env })()
end)
set("og", api.toggle_lazygit)

set("oP", api.toggle_persistent_floating_terminal("pgcli", pg_cmd, {
  force_new = true
}))
set("oL", api.toggle_persistent_floating_terminal("alogs", { "fish", "-c", "alogs" }, {
  force_new = true
}))
set("oA", api.toggle_persistent_floating_terminal("aspire", { "aspire", "run" }, {
  force_new = true
}))
set("oC", api.toggle_persistent_floating_terminal("calc", { "calc" }, {
  force_new = true
}))
set("oT", function()
  local cmd = "fish && cd " .. api.get_cwd()
  api.toggle_persistent_floating_terminal("fish", cmd, {
    force_new = true
  })()
end)
set("oG", function() api.toggle_lazygit(true) end)
-- }}}

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

-- Lazygit is weird, if you exit it you shift right so you counter-balance it by
-- going left
vim.api.nvim_create_autocmd({
    "FileType",
  },
  {
    pattern = "ft_lazygit",
    callback = function()
      vim.keymap.set("t", "<A-;>", function()
        vim.cmd("stopinsert")
        vim.fn.feedkeys("gg")
        vim.fn.feedkeys("^") -- beginning of the sentence
      end, { buffer = true })
    end
  })
-- gb set by ../plugins/blame.lua

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
    vim.cmd("noremap <silent> " .. fr[i + 1] .. " " .. tostring(i))
    vim.cmd("noremap <silent> " .. tostring(i) .. " " .. fr[i + 1])
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

vim.keymap.set({ "x", "o" }, "af", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "aa", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@parameter.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ia", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ab", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end)

vim.keymap.set("n", "<leader>sl", function()
  require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end)
vim.keymap.set("n", "<leader>sh", function()
  require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
end)

vim.keymap.set({ "n", "x", "o" }, "]f", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[f", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]a", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[a", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]b", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
end)
vim.keymap.set({ "n", "x", "o" }, "[b", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@local.scope", "locals")
end)
vim.keymap.set({ "n", "x", "o" }, "]z", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
end)
vim.keymap.set({ "n", "x", "o" }, "[z", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@fold", "folds")
end)
vim.keymap.set({ "n", "x", "o" }, "]gc", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@comment.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[gc", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@comment.outer", "textobjects")
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

local function comment_above_or_below(lnum)
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local comment_row = row + lnum
  local l_cms, r_cms = string.match(vim.bo.commentstring, '(.*)%%s(.*)')
  l_cms = vim.trim(l_cms)
  r_cms = vim.trim(r_cms)
  if #r_cms ~= 0 then
    r_cms = ' ' .. r_cms
  end
  vim.api.nvim_buf_set_lines(0, comment_row, comment_row, false, { l_cms .. ' ' .. r_cms})
  vim.api.nvim_win_set_cursor(0, { comment_row + 1, 0 })
  vim.api.nvim_command('normal! ==')
  vim.api.nvim_win_set_cursor(0, { comment_row + 1, #vim.api.nvim_get_current_line() - #r_cms - 1 })
  vim.api.nvim_feedkeys('a', 'ni', true)
end

vim.keymap.set("n", "gco", function()
  comment_above_or_below(0)
end)

vim.keymap.set("n", "gcO", function()
  comment_above_or_below(-1)
end)

set("rp", ":%s/")

vim.keymap.set('n', "gca", function()
  local l_cms, r_cms = string.match(vim.bo.commentstring, '(.*)%%s(.*)')
  local comment = l_cms .. ' ' .. r_cms
  local line = vim.api.nvim_get_current_line() .. " " .. comment
  vim.api.nvim_set_current_line(line)
  vim.api.nvim_feedkeys('A ', 'ni', true)
end)

vim.keymap.set("n", "<leader>cc", "gcc", { remap = true })
vim.keymap.set("n", "<leader>co", "gco", { remap = true })
vim.keymap.set("n", "<leader>cO", "gcO", { remap = true })
vim.keymap.set("n", "<leader>ca", "gca", { remap = true })

vim.keymap.set("t", "<A-esc>", "<c-\\><c-n>", { remap = false })
vim.keymap.set("t", "<A-;>", "<c-\\><c-n>", { remap = false })

vim.keymap.set("t", "<C-6>", "<c-\\><c-n><c-6>")
vim.keymap.set("t", "<C-->", "<c-\\><c-n><c-6>")
