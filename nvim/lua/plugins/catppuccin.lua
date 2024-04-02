return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = true,
  opts = {
    integrations = {
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = true,
      mason = true,
      neotest = true,
      dap = true,
      dap_ui = true,
      rainbow_delimiters = true,
      telescope = { enabled = true },
      illuminate = { enabled = true, lsp = false },
      dashboard = true,
    },
  },
}
