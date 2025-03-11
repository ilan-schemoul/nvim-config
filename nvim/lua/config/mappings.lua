-- NOTE: nvim-various-textobjs adds many text objects
-- https://github.com/chrisgrieser/nvim-various-textobjs?tab=readme-ov-file#list-of-text-objects
-- NOTE: Many mappings defined inside plugins (grep "keys =" to find those)

local custom_commands = require("config/custom-commands")

local fr = { "à", "&", "é", "\"", "'", "(", "-", "è", "_", "ç" }
local hjkl = { "h", "j", "k", "l" }

local function set(keys, cmd)
  vim.keymap.set("n", "<leader>" .. keys, cmd)
end

local function setv(keys, cmd)
  vim.keymap.set("v", "<leader>" .. keys, cmd)
end

vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, })
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({
   severity = vim.diagnostic.severity.ERROR,
 })
end)

set("lD", vim.diagnostic.open_float)
set("lh", vim.lsp.buf.hover)
set("li", "<cmd>Telescope lsp_references<cr>")
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

set("L", "<cmd>Lazy<cr>")

set("o", custom_commands.open_file)
set(";", custom_commands.open_file_with_extension)
set(".", custom_commands.open_file_with_extension)

vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)

set("A", "<cmd>NodeAction<cr>")

-- Open a new window with same file as current buffer
set("bh", "<cmd>vsplit<cr>")
set("bj", "<cmd>belowright split<cr>")
set("bk", "<cmd>topleft split<cr>")
set("bl", "<cmd>botright vs<cr>")
set("bx", custom_commands.close_buffer)
-- Close all buffers but one
set("bX", custom_commands.close_other_tab_buffers)

set("N", function()
  if vim.wo[0].relativenumber or vim.wo[0].number then
    vim.wo[0].number = false
    vim.wo[0].relativenumber = false
  else
    vim.wo[0].number = true
    vim.wo[0].relativenumber = true
  end
end)

-- Close current buffer
set("q", custom_commands.close_window_if_not_last)
-- Close neovim
set("Q", "<cmd>qa!<cr>")
set("R", "<cmd>Restart<cr>")

set("m", "<cmd>Mason<cr>")

-- Echo current file
set("F", "<cmd>echo @%<cr>")

set("u", "<cmd>Telescope undo<cr>")

-- set("ty") by neoclip.lua
set("tt", "<cmd>Telescope<cr>")
set("tg", "<cmd>Telescope live_grep<cr>")
setv("tg", function()
  local selection_text = custom_commands.get_visual_selection()
  require('telescope.builtin').live_grep({ default_text = selection_text })
end)
set("tG", "<cmd>Telescope grep_string<cr>")
-- Reopen last search (so useful)
set("tr", "<cmd>Telescope resume<cr>")
set("tz", "<cmd>Telescope buffers<cr>")
set("tf", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
setv("tf", function()
  local selection_text = custom_commands.get_visual_selection()
  require('telescope.builtin').current_buffer_fuzzy_find({ default_text = selection_text })
end)
set("tF", function()
  local word = vim.fn.expand('<cword>')
  require('telescope.builtin').current_buffer_fuzzy_find({ default_text = word })
end)
set("tb", require("telescope").extensions.git_file_history.git_file_history)
set("ts", "<cmd>Tabby jump_to_tab<cr>")

-- Switch to tab 4 with <leader>t4
for i = 0, 9 do
  if os.getenv("KEYBOARD_FR") then
    set("t" .. fr[i + 1], "<cmd>" .. tostring(i) .. "tabn" .. "<cr>")
  end

  set("t" .. tostring(i), "<cmd>" .. tostring(i) .. "tabn" .. "<cr>")
end

set("tq", function() require("telescope.builtin").quickfix({
  trim_text = true,
  path_display = { "smart" }
}) end)

set("pn", custom_commands.open_unused_term_or_create)
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
set("vm", "<cmd>next ~/.config/nvim/lua/config/mappings.lua<cr>")
set("vg", "<cmd>Telescope live_grep search_dirs=~/.config/nvim<cr>")
set("vl", "<cmd>Telescope find_files search_dirs=~/.config/nvim<cr>")
set("vt", "<cmd>e ~/nvim-main/todo.norg<cr>")
set("vv", "<cmd>mapclear | source ~/.config/nvim/init.lua<cr>")

set("nm", "<cmd>e ~/notes/memory.norg<cr>")
set("nM", "<cmd>botright 30vnew ~/notes/memory.norg | set invrelativenumber | set invnumber<cr>")
set("nl", "<cmd>Telescope find_files search_dirs={'~/notes'} follow=true<cr>")
set("ng", "<cmd>Telescope live_grep search_dirs={'~/notes'}<cr>")
set("nn", custom_commands.create_org_file)
-- ../plugins/venn.lua (draw diagram in ASCII)
set("nd", custom_commands.toggle_venn)
set("no", "<cmd>Bmessages<cr>")

-- <space><backspace>
set("<BS>", function()
  require("notify").dismiss({pending = true, silent = true})
end)

-- ../plugins/treesitter.lua
set("sc", "1z=")
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

-- Lazygit (incredibly good)
-- We also disable jk (houdini) for lazygit
set("go", function()
  local path = vim.fn.expand('%:h')

  if path:find("term://") or path:find("oil://") or not vim.fn.filereadable(path) then
    path = vim.fn.getcwd()
  end

  require('FTerm').scratch({
    ft = "lazygit",
    cmd = "cd " .. path .. " && lazygit",
    dimensions = {
      height = 0.95,
      width = 0.95,
    },
    on_exit = function()
      vim.cmd("Gitsigns refresh")
      vim.cmd("windo e")
    end
  })
end)

set("gl", require("nvim-gerrit").list_changes)

-- Add ^ to escape Lazygit (hj is used for navigation so I disabled it in lazygit)
-- NOTE: on some azerty ^ is a dead key so you gotta press it twice
vim.api.nvim_create_autocmd({
    "FileType",
  },
  {
    pattern = "lazygit",
    callback = function()
      vim.keymap.set("t", "^", function()
        vim.cmd("stopinsert")
        vim.fn.feedkeys("gg")
        vim.fn.feedkeys("^") -- beginning of the sentence
      end, { buffer = true })
    end
  })
-- gb set by ../plugins/blame.lua

for _, key in ipairs(hjkl) do
  -- Focus window (e.g: <A-l> focus right window)
  vim.keymap.set({ "t", "n", "i" }, "<A-" .. key .. ">", "<C-\\><C-N><C-w>" .. key)

  -- Move window
  local upper = string.upper(key)
  vim.keymap.set({ "t", "n", "i" }, "<A-" .. upper .. ">", "<C-\\><C-N><C-w>" .. upper)
end

if os.getenv("KEYBOARD_FR") then
  for i = 0, 9 do
    -- HACK: use noremap instead of vim.keymap.set as otherwise motions
    -- such as d"j (d3j) does not work
    vim.cmd("noremap <silent> " .. fr[i + 1] .. " " .. tostring(i))
    vim.cmd("noremap <silent> " .. tostring(i) .. " " .. fr[i + 1])
  end
end

-- HACK: ugly hack to clear the terminal (can help with lag)
vim.keymap.set("t", "<C-q>", "<c-\\><c-n><cmd>set scrollback=1 | sleep 100m | set scrollback=10000<cr>")

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

-- Azerty keyboard support being what it is I need these to have
-- similar experience to qwerty
vim.cmd([[
  " Custom env variable
  if !empty($KEYBOARD_FR)
    nmap <silent> ù `
  endif

  noremap <C--> <C-^>
  " Does not work with every azerty keyboards for some reason
  tmap <C-^> <C-\><C-N><C-^>
]])
