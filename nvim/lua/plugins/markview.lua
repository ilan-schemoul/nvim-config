return {
  "OXY2DEV/markview.nvim",
  dependencies = {
    "catppuccin/nvim",
  },
  ft = { "markdown", "codecompanion" },
  opts = {
    preview = {
      filetypes = { "markdown", "codecompanion" },
      ignore_buftypes = {},
    },
  },
  config = function(_, opts)
    local presets = require("markview.presets");
    opts.markdown = {
      headings = presets.headings.simple,
    }
    require("markview").setup(opts)
  end,
}

