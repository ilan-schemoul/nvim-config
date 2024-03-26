return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>f",
      "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>",
      mode = { "n", "v" },
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
    },
  },
}
