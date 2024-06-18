return {
  "petertriho/nvim-scrollbar",
  config = function()
    require("gitsigns").setup()
    require("scrollbar.handlers.gitsigns").setup()
    require("scrollbar").setup()
  end,
}

