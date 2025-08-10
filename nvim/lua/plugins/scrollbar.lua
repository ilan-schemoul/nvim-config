return {
  "petertriho/nvim-scrollbar",
  enabled = false,
  event = "VimEnter",
  config = function()
    -- require("scrollbar.handlers.gitsigns").setup()
    require("scrollbar").setup()
  end,
}

