return {
  "hedyhli/outline.nvim",
  keys = {
    { "<leader>so", "<cmd>Outline<cr>" },
  },
  opts = {
    outline_window = {
      focus_on_open = false,
      position = "left",
      auto_width = {
        enabled = true,
        max_width = 50,
      },
    },
  },
}

