return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "NormalBufferEnter" },
  opts = {
    mode = "cursor",
    max_lines = 8,
    min_window_height = 40,
  },
}

