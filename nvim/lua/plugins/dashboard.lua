return {
  dir = '/home/ilan/code/forks/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    local curl = require("plenary.curl")
    local res = curl.get("wttr.in/?format=1")
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = {},
        shortcut = {},
        footer = { "", res.body },
      }
    }
    vim.cmd("highlight DashboardFooter cterm=italic gui=italic guifg=#6e738d")
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
};
