return {
  "danielfalk/smart-open.nvim",
  event = "VeryLazy",
  dependencies = {
    "kkharji/sqlite.lua",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  init = function()
    require("telescope").load_extension("smart_open")
  end,
  opts = {
    match_algorithm = "fzf",
  },
}
