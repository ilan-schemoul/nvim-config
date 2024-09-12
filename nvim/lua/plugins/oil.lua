return {
  "stevearc/oil.nvim",
  opts = {
    delete_to_trash = true,
    default_file_explorer = true,
  },
  -- Need to disable lazy for default_file_explorer
  lazy = false,
  cmd = {
      "Oil",
  },
  keys = {
      { "<leader>d", "<cmd>Oil<cr>", silent = true }
  },
}
