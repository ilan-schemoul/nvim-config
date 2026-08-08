return {
  "isak102/telescope-git-file-history.nvim",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "tpope/vim-fugitive"
  },
  setup = function()
    require("telescope").load_extension("git_file_history")
  end,
  opts = {},
}

