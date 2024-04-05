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
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          if server_name ~= "lua_ls" then
            require("lspconfig")[server_name].setup({})
          end
        end,
      })
    end,
  },
}
