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

    -- Some LSP servers don't play well with gq, they ignore the textwidth for some
    -- reasons. For those, we need to remove the formatexpr they set. Others such
    -- as bashls, clangd work fine anyway.
    local restore_gq = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
    end

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
       on_attach = restore_gq,
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
     vim.lsp.enable('ast_grep')

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
      on_attach = restore_gq,
    })

    vim.lsp.config('bashls', {
      on_attach = restore_gq,
    })


    vim.lsp.config('*', {
      capabilities = capabilities,
      flags = { debounce_text_changes = 200 },
    })

    require("mason-lspconfig").setup({
      -- I need to install shellcheck too with bashls
      ensure_installed = { "lua_ls", "bashls" }
    })
  end,
}
