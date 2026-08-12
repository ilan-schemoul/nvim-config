local config = require('config/config')

return {
  enabled = false,
  "catppuccin/nvim",
  event = "VimEnter",
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd("colorscheme catppuccin-macchiato")
  end,
  priority = 1000,
  opts = {
    integrations = {
      gitsigns = false,
    },
    transparent_background = config.ui.transparent_background,
    dim_inactive = {
      enabled = not config.ui.transparent_background,
      percentage = 0.7
    },
  },
}
