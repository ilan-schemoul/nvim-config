return {
  "danielfalk/smart-open.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  init = function()
    require("telescope").load_extension("smart_open")
  end,
  keys = {
    { "<leader>ll", "<cmd>Telescope smart_open<cr>", silent = true },
  },
  opts = {
    match_algorithm = "fzf",
  },
}
