return {
  "akinsho/git-conflict.nvim",
  lazy = false,
  keys = {
    { "<leader>xo", "<Plug>(git-conflict-ours)" },
    { "<leader>xt", "<Plug>(git-conflict-theirs)" },
    { "<leader>xb", "<Plug>(git-conflict-both)" },
    { "<leader>xn", "<Plug>(git-conflict-none)" },
    { "]x", "<Plug>(git-conflict-next-conflict)" },
    { "[x", "<Plug>(git-conflict-previous-conflict)" },
    { "<leader>xq", "<cmd>GitConflictListQf<cr> " },
  },
  opts = {
    default_mappings = false,
  },
}

