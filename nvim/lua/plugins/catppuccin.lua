local config = require('config/config')

return {
  "catppuccin/nvim",
  event = "VimEnter",
  config = function(opts)
    require('catppuccin').setup(opts)
    vim.cmd("colorscheme catppuccin-macchiato")
  end,
  priority = 1000,
  opts = {
    default_integrations = true,
    transparent_background = config.ui.transparent_background,
    dim_inactive = {
      enabled = not config.ui.transparent_background,
      percentage = 0.7
    },
  },
}
