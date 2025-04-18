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

    -- NOTE: At work we have virtual env with sometimes old node. Old node
    -- don't work with LSP.
    local path = "/home/ilan/.nvm/versions/node/v16.20.2/bin"
    local cmd_env = { PATH = path .. ":" .. vim.env.PATH }

    vim.lsp.handlers["textDocument/publishDiagnostics"] =
     vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
       update_in_insert = false
     })

    require'lspconfig'.fish_lsp.setup{}

    require("mason-lspconfig").setup()
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          cmd_env = cmd_env,
          capabilities = capabilities,
          flags = { debounce_text_changes = 200 },
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
