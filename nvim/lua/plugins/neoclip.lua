return {
  "AckslD/nvim-neoclip.lua",
  opts = {},
  keys = {
    { "<leader>ty", "<cmd>Telescope neoclip<cr>" }
  },
  config = function()
    require('telescope').load_extension('neoclip')
    -- FIXME: neoclip doesn't work
  end,
}
