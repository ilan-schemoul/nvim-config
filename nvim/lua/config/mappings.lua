-- https://github.com/chrisgrieser/nvim-various-textobjs?tab=readme-ov-file#list-of-text-objects

local get_tab_folder = require("config/utils").get_tab_folder

local fr = { "à", "&", "é", "\"", "'", "(", "-", "è", "_", "ç" }
local hjkl = { "h", "j", "k", "l" }

local function set(keys, cmd)
  vim.keymap.set("n", "<leader>" .. keys, cmd)
end

-- Many mappings defined inside plugins (grep "keys =" to find those)

set("[d", vim.diagnostic.goto_prev)
set("]d", vim.diagnostic.goto_next)

set("lD", vim.diagnostic.open_float)
set("lh", vim.lsp.buf.hover)
set("li", "<cmd>Telescope lsp_references<cr>")
set("ld", "<cmd>Telescope lsp_definitions<cr>")
set("lb", "<cmd>Telescope diagnostic<cr>")
set("ls", "<cmd>Telescope lsp_workspace_symbols<cr>")
set("lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
set("ln", vim.lsp.buf.rename)
set("la", vim.lsp.buf.code_action)
set("lt", require("lsp_lines").toggle)
set("ll", "<cmd>Telescope smart_open<cr>")

set("o", _G.OpenFile)
set(";", _G.OpenFileWithExtension)
set(".", _G.OpenFileWithExtension)

vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)

set("A", "<cmd>NodeAction<cr>")

set("bh", "<cmd>vsplit<cr>")
set("bj", "<cmd>belowright split<cr>")
set("bk", "<cmd>topleft split<cr>")
set("bl", "<cmd>botright vs<cr>")
set("bn", "<cmd>FocusSplitNicely<cr>")
set("bx", _G.CloseBuffer)

set("N", "<cmd>set invrelativenumber | set invnumber<cr>")

set("q", _G.CloseWindowIfNotLast)
set("Q", "<cmd>qa!<cr>")

set("m", "<cmd>Mason<cr>")

set("F", "<cmd>echo @%<cr>")

set("u", "<cmd>Telescope undo<cr>")

set("tt", "<cmd>Telescope<cr>")
set("tg", "<cmd>Telescope live_grep<cr>")
set("tr", "<cmd>Telescope resume<cr>")
set("tz", "<cmd>Telescope buffers<cr>")
set("tq", "<cmd>Telescope quickfix<cr>")

set("tw", function()
  require("telescope-tabs").list_tabs({
    entry_formatter = function(tab_id, _, _, _, _)
      return get_tab_folder(tab_id)
    end,
    entry_ordinal = function(tab_id, _, _, _, _)
      return get_tab_folder(tab_id)
    end,
  })
end)
set("t-", require("telescope-tabs").go_to_previous)

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

set("pn", _G.OpenUnusedTermOrCreate)
set("pN", "<cmd>term<cr>")
set("ph", "<cmd>vsplit | lua _G.OpenUnusedTermOrCreate()<cr>")
set("pj", "<cmd>belowright split | lua _G.OpenUnusedTermOrCreate()<cr>")
set("pk", "<cmd>topleft split | lua _G.OpenUnusedTermOrCreate()<cr>")
set("pl", "<cmd>botright vs | lua _G.OpenUnusedTermOrCreate()<cr>")
set("pH", "<cmd>vsplit | term <cr>")
set("pJ", "<cmd>belowright split | term <cr>")
set("pK", "<cmd>topleft split | term <cr>")
set("pL", "<cmd>botright vs | term <cr>")
set("pr", "<cmd>SendToTerm !!<cr>")
set("ps", "<cmd>SendToTerm<cr>")

set("pp", "<cmd>put<cr>")
set("pP", "<cmd>put!<cr>")

set("tf", "<cmd>lua require('telescope-tabs').list_tabs()<cr>")
set("tc", "<cmd>Telescope neoclip<cr>")
set("tn", "<cmd>tabnew<cr>")
set("tx", "<cmd>tabclose<cr>")
set("tl", "<cmd>tabnext<cr>")
set("th", "<cmd>tabprevious<cr>")
set("tL", "<cmd>+tabmove<cr>")
set("tH", "<cmd>-tabmove<cr>")

set("vc", "<cmd>next ~/.config/nvim/init.lua<cr>")
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
set("nn", _G.create_org_file)
-- ../plugins/venn.lua
set("nd", ":lua Toggle_venn()<cr>")

-- ../plugins/treesitter.lua
set("sc", "1z=")
-- Can't use <leader>sl as it is used by for TS swapping
set("s=", "<cmd>CustomTelescopeSpellSuggest<cr>")
set("sr", "<cmd>spellr<cr>")
set("sg", "zg")
set("sw", "zw")
set("sb", "zw")

-- We also disable jk (houdini) for lazygit
set("go", function()
  local path = vim.fn.expand('%:h')

  if path:find("term://") or not vim.fn.filereadable(path) then
    path = vim.fn.getcwd()
  end

  require('FTerm').scratch({
    ft = "lazygit",
    cmd = "cd " .. path .. " && lazygit",
    dimensions = {
      height = 0.95,
      width = 0.95,
    },
  })
end)
vim.api.nvim_create_autocmd({
    "FileType",
  },
  {
    pattern = "lazygit",
    callback = function()
      vim.keymap.set("t", "^^", function()
        vim.cmd("stopinsert")
        vim.fn.feedkeys("gg")
        vim.fn.feedkeys("^")
      end, { buffer = true })
    end
  })
set("gq", require("config/gerrit-quickfix").load_interactive_input)
set("gb", ":BlameToggle<cr>")

for _, key in ipairs(hjkl) do
  vim.keymap.set({ "t", "n", "i" }, "<A-" .. key .. ">", "<C-\\><C-N><C-w>" .. key)

  -- Move window
  local upper = string.upper(key)
  vim.keymap.set({ "t", "n", "i" }, "<A-" .. upper .. ">", "<C-\\><C-N><C-w>" .. upper)
end

if os.getenv("KEYBOARD_FR") then
  for i = 0, 9 do
    -- WORKAROUND: use noremap instead of vim.keymap.set as otherwise motions
    -- such as d"j (d3j) does not work
    vim.cmd("noremap <silent> " .. fr[i + 1] .. " " .. tostring(i))
    vim.cmd("noremap <silent> " .. tostring(i) .. " " .. fr[i + 1])
    -- vim.keymap.set("n", fr[i], tostring(i), { remap = false, silent = true })
    -- vim.keymap.set("n", tostring(i), fr[i], { remap = false })
  end
end

vim.keymap.set("t", "<C-q>", "<c-\\><c-n><cmd>set scrollback=1 | sleep 100m | set scrollback=10000<cr>")

vim.cmd([[
  " Custom env variable
  if !empty($KEYBOARD_FR)
    nmap <silent> ù `
  endif

  noremap <C--> <C-^>
  tmap <C-^> <C-\><C-N><C-^>

  inoremap <C-k> <Up>
  inoremap <C-h> <Left>
  inoremap <C-l> <Right>
  inoremap <C-j> <Down>
]])
