return {
  "AckslD/nvim-neoclip.lua",
  opts = {},
  keys = {
    { "<leader>tc", "<cmd>Telescope neoclip<cr>" }
  },
  config = function()
    require('telescope').load_extension('neoclip')
  end,
}
