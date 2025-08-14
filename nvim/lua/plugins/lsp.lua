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

     vim.lsp.config("pylsp", {
       capabilities = capabilities,
       -- mypy is slow, if we make too much requests at once he will
       -- be slower to respond
       flags = {
         debounce_text_changes = 600,
       },
       settings = {
         pylsp = {
           plugins = {
                jedi = {
                    enabled = true,
                },
                pylint = {
                    enabled = true,
                },
                -- Disable all other linters
                pyflakes = {
                    enabled = false,
                },
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
                yapf = {
                    enabled = false,
                },
           },
         },
       }
     })
     vim.lsp.enable('pylsp')
     vim.lsp.enable('ruff')

    vim.lsp.config('clangd', {
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--header-insertion=never"
      }
    })

    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    vim.lsp.config('*', {
      capabilities = capabilities,
      flags = { debounce_text_changes = 200 },
    })

    require("mason-lspconfig").setup({
      -- I need to install shellcheck too with bashls
      ensure_installed = { "lua_ls", "bashls", "fish_lsp" }
    })
  end,
}
