return {
  "catppuccin/nvim",
  name = "catppuccin",
  init = function()
    vim.cmd("colorscheme catppuccin")
  end,
  priority = 1000,
  lazy = true,
  opts = {
    default_integrations = true,
    dim_inactive = {
      enabled = true,
    },
  },
}
