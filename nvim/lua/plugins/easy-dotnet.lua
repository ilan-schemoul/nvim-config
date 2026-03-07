return {
  "GustavEikaas/easy-dotnet.nvim",
  cmd = { "Dotnet" },
  ft = { "cs" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "neovim/nvim-lspconfig"
  },
  opts = {
    lsp = {
      auto_refresh_codelens = false,
      config = {},
    },
  }
}

