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

      local custom_bashls = false
      if vim.fn.filereadable("node-16") then
        custom_bashls = true
        require("lspconfig").bashls.setup({
          capabilities = capabilities,
          cmd = { "node-16", "/home/ilan/.local/share/nvim/mason/bin/bash-language-server", "start" },
        })
      end

      -- Whether servers that are set up (via lspconfig) should be automatically
      -- installed if they're not already installed.
      require("mason").setup({ automatic_installation = true })
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          if server_name ~= "lua_ls" and not (server_name == "bashls" and custom_bashls) then
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end
        end,
      })
    end,
  },
}
