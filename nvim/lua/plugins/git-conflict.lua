return {
  "akinsho/git-conflict.nvim",
  keys = {
    { "<leader>xo", "<Plug>(git-conflict-ours)", desc = "Take ours (conflict)" },
    { "<leader>xt", "<Plug>(git-conflict-theirs)", desc = "Take theirs (conflict)" },
    { "<leader>xb", "<Plug>(git-conflict-both)", desc = "Take both (conflict)" },
    { "<leader>xn", "<Plug>(git-conflict-none)", desc = "Take none (conflict)" },
    { "<leader>xq", "<Plug>(git-conflict-list-qf)", desc = "List conflicts in quickfix" },
    { "<leader>xr", "<cmd>GitConflictRefresh<cr>", desc = "Refresh conflicts" },
    { ")x", "<Plug>(git-conflict-next-conflict)", desc = "Next conflict" },
    { "(x", "<Plug>(git-conflict-previous-conflict)", desc = "Previous conflict" },
    { "]x", "<Plug>(git-conflict-next-conflict)", desc = "Next conflict" },
    { "[x", "<Plug>(git-conflict-previous-conflict)", desc = "Previous conflict" },
    { "<leader>xq", "<cmd>GitConflictListQf<cr> ", desc = "List conflicts in quickfix" },
  },
  opts = {
    default_mappings = false,
  },
}

