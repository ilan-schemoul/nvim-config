return {
  "danielfalk/smart-open.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  lazy = true,
  keys = {
    { "<leader>ll", "<cmd>Telescope smart_open<cr>" },
  },
  opts = {
    match_algorithm = "fzf",
  },
  config = function(_, opts)
    require("smart-open").setup(opts)
    require("telescope").load_extension("smart_open")
  end,
}
