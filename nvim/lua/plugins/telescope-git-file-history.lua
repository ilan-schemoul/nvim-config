return {
  "isak102/telescope-git-file-history.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "tpope/vim-fugitive"
  },
  lazy = true,
  opts = {},
  setup = function()
    require("telescope").load_extension("git_file_history")
  end,
}

