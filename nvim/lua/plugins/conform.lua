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
  init = function()
    local function format()
      require("conform").format({ async = true })
    end

    local function d_format()
      vim.defer_fn(format, 2000)
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.cs",
      callback = d_format,
    })
  end,
  config = function()
    local formatters = require("mason-bridge").get_formatters()
    formatters.cs = formatters.csharp
    require("conform").setup({
      formatters_by_ft = formatters,
    })
  end,
}
