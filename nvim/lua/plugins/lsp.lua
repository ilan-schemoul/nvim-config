return
{
  "neovim/nvim-lspconfig",
  event = "NormalBufferEnter",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "RubixDev/mason-update-all",
  },
  config = function(_, _)
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Some LSP servers don't play well with gq, they ignore the textwidth for some
    -- reasons. For those, we need to remove the formatexpr they set. Others such
    -- as bashls, clangd work fine anyway.
    local restore_gq = function(_, bufnr)
      vim.bo[bufnr].formatexpr = ""
    end

    vim.diagnostic.config({ update_in_insert = false, signs = false })

     vim.lsp.enable('ruff')
     -- vim.lsp.enable('ast_grep')
     vim.lsp.config('ty', {
       settings = {
         ty = {
           diagnosticMode = 'off',
         },
       }
     })

     vim.lsp.config('roslyn_ls', {
      cmd = {
          "roslyn-language-server",
          "--stdio",
          -- Start once in background, all other connect to it
          "--daemon-mode"
      },
      settings = {
        ["csharp|background_analysis"] = {
          dotnet_analyzer_diagnostics_scope = "VisibleFilesAndOpenFilesWithPreviouslyReportedDiagnostics",
          dotnet_compiler_diagnostics_scope = "VisibleFilesAndOpenFilesWithPreviouslyReportedDiagnostics"
        },
      }
    })
    vim.lsp.enable('roslyn_ls')

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
