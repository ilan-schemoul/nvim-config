return {
  "AckslD/nvim-neoclip.lua",
  event = "VeryLazy",
  opts = {},
  init = function()
    require('telescope').load_extension('neoclip')
  end,
}
