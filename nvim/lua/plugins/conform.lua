return {
  "stevearc/conform.nvim",
  priority = 0,
  dependencies = {
    "frostplexx/mason-bridge.nvim",
  },
  keys = {
    {
      "<leader>ff",
      "<cmd>lua require('conform').format({ async = true })<cr>",
      mode = { "n", "v" },
    },
  },
  config = function()
    local formatters = require("mason-bridge").get_formatters()
    formatters.cs = formatters.csharp
    require("conform").setup({
      formatters_by_ft = formatters,
    })
  end,
}
