vim.g.auto_save_silent = 1
vim.g.auto_save = 1
vim.g.code_action_menu_show_details = false
vim.NERDSpaceDelims = 1
vim.g.NERDCustomDelimiters = {
  c = { left = '//', right = '' }
}
vim.g.vista_default_executive = 'nvim_lsp'
vim.g.asyncrun_open = 6 -- for AsyncTask

vim.g.chadtree_settings = {
  view = {
    width = 30
  },
  keymap = { copy_relname = { '<c-c>' } },
}

require'lspconfig'.hdl_checker.setup{}
require'lspconfig'.gdscript.setup{}

require("nvim-tree").setup()
require'toggle_lsp_diagnostics'.init()
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
require("nvim-dap-virtual-text").setup()
require("trouble").setup{}
require"fidget".setup{}
require'colorizer'.setup()
require('gitblame').setup {
    enabled = false,
}

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
}

require('telescope').load_extension('fzf')
require('telescope').setup{ defaults = { file_ignore_patterns = {"node_modules"} } }

require("coq_3p") {
    { src = "copilot", short_name = "COP", accept_key = "df" },
}

vim.api.nvim_set_var("copilot_filetypes", {
      ["dap-repl"] = false,
})

if vim.g.obsidian_dir then
   require("obsidian").setup({
   dir = vim.g.obsidian_dir,
   completion = {
      nvim_cmp = false, -- if using nvim-cmp, otherwise set to false
   },
   })
end

require'regexplainer'.setup {
  mode = 'narrative', -- TODO: 'ascii', 'graphical'
  auto = false,
  filetypes = {
    'html',
    'js',
    'cjs',
    'mjs',
    'ts',
    'jsx',
    'tsx',
    'cjsx',
    'mjsx',
  },
  debug = false, 
  display = 'popup',
  mappings = {
    toggle = 'gR',
  },
  narrative = {
    separator = '\n',
  },
}

if not os.getenv("IS_ARISTA_SERVER") then
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { "markdown", "markdown_inline" },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = {},

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      additional_vim_regex_highlighting = { "markdown" },
    },
  }
end

require("treesitter-context").setup()

require("dapui").setup({
  controls = {
    enabled = false,
  },
})

local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

vim.g.code_action_menu_window_border = 'single'

require'bufferline'.setup { auto_hide = true, minimum_padding = 0, maximum_padding = 0, icons = { filetype = { enabled = false }, modified = { button = false } } }

require('leap').add_default_mappings()

vim.keymap.del({'x', 'o'}, 'x')
vim.keymap.del({'x', 'o'}, 'X')

-- below code to autoregister null-ls plugins installed by manson
-- it is commented because of this bug https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1190
-- (it gives a ugly warning at the start)
-- local function null_ls_default_handler(source_name)
    -- local ok, null_ls = pcall(require, "null-ls")
    -- if not ok then
        -- vim.notify("Error missing null-ls!")
        -- return
    -- end
    -- --vim.notify("Null-ls server " .. source_name .. " registered.")

      -- -- Unfortunately this generates a warning
      -- -- Register builtin formatters
      -- if null_ls.builtins.formatting[source_name] ~= nil then
          -- null_ls.register(null_ls.builtins.formatting[source_name])
      -- end
      -- -- Register builtin code actions
      -- if null_ls.builtins.code_actions[source_name] ~= nil then
          -- null_ls.register(null_ls.builtins.code_actions[source_name])
      -- end
      -- -- Register builtin diagnostics
      -- if null_ls.builtins.diagnostics[source_name] ~= nil then
          -- null_ls.register(null_ls.builtins.diagnostics[source_name])
      -- end
      -- -- Register builtin diagnostics
      -- if null_ls.builtins.hover[source_name] ~= nil then
          -- null_ls.register(null_ls.builtins.hover[source_name])
      -- end
-- end

-- require("mason-null-ls").setup_handlers {
    -- null_ls_default_handler
-- }
local null_ls = require "null-ls"

require("mason-null-ls").setup({
})

null_ls.setup()

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {'*.tac'},
  callback = function(ev)
    vim.lsp.start({
      name = 'tacc',
      cmd = {'/usr/bin/artaclsp'},
      cmd_args = {'-I', '/bld/'},
      root_dir = '/src',
    })
  end
})

local r = require"renamer"
r.setup {}
r._apply_workspace_edit = function(resp)
local params = vim.lsp.util.make_position_params()
local results_lsp, _ = vim.lsp.buf_request_sync(0,
    require"renamer.constants".strings.lsp_req_rename, params)
local client_id = results_lsp and next(results_lsp) or nil
local client = vim.lsp.get_client_by_id(client_id)
require"vim.lsp.util".apply_workspace_edit(resp, client.offset_encoding)
end

require("oil").setup()

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require('neotest-rust')
  },
})

vim.cmd.colorscheme "catppuccin-mocha"

require("catppuccin").setup({
    integrations = {
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mason = true,
        neotest = true,
        dap = true,
        dap_ui = true,
        rainbow_delimiters = true,
        telescope = { enabled = true },
        illuminate = { enabled = true, lsp = true },
    }
})
