return {
  "stevearc/conform.nvim",
  priority = 0,
  dependencies = {
    "frostplexx/mason-bridge.nvim",
  },
  keys = {
    {
      "<leader>f",
      "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>",
      mode = { "n", "v" },
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = require("mason-bridge").get_formatters({
        overrides = {
          linters = {
            lua = { "stylua" },
          },
        },
      }),
    })
  end,
}
