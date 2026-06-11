local config = require('config/config')

return {
  "catppuccin/nvim",
  name = "catppuccin",
  init = function()
    vim.cmd("colorscheme catppuccin-macchiato")
  end,
  priority = 1000,
  lazy = true,
  opts = {
    default_integrations = true,
    transparent_background = config.ui.transparent_background,
    dim_inactive = {
      enabled = not config.ui.transparent_background,
    },
  },
}
