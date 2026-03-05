return {
  "GustavEikaas/easy-dotnet.nvim",
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

