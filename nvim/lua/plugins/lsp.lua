return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      "RubixDev/mason-update-all",
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    },
    config = function(_, _)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason").setup({ automatic_installation = true })
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
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
        ["pyright"] = function(_)
          require("lspconfig").pyright.setup({
            capabilities = capabilities,
            settings = {
              python = {
                analysis = {
                  diagnosticMode = 'openFilesOnly',
                },
              },
            },
          })
        end,
    })
    end,
  },
}
