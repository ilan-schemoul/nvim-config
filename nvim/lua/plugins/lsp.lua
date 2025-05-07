return
{
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "RubixDev/mason-update-all",
  },
  config = function(_, _)
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.handlers["textDocument/publishDiagnostics"] =
     vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
       update_in_insert = false
     })

    require'lspconfig'.fish_lsp.setup{}

    require("mason-lspconfig").setup()
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          flags = { debounce_text_changes = 200 },
        })
      end,
      ["pylsp"] = function(_)
        require("lspconfig").pylsp.setup({
          settings = {
            plugins = {
              -- Basic things (autocompletion, renaming etc.)
              jedi = {
                enabled = true,
              },
              pylint = {
                enabled = true,
              },
              -- Disable all other linters
              autopep8 = {
                enabled = false,
              },
              flake8 = {
                enabled = false,
              },
              pycodestyle = {
                enabled = false,
              },
              mccabe = {
                enabled = false,
              },
            },
          },
        })
      end,
      ["clangd"] = function(_)
        require("lspconfig").clangd.setup({
          capabilities = capabilities,
          cmd = {
            "clangd",
            "--header-insertion=never"
          }
        })
      end,
      ["lua_ls"] = function(_)
        require("lspconfig").lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
      end,
    })
  end,
}
