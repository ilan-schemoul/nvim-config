return {
  "akinsho/git-conflict.nvim",
  event = "NormalBufferEnter",
  keys = {
    { "<leader>xq", "<Plug>(git-conflict-list-qf)", desc = "List conflicts in quickfix" },
    { "<leader>xR", "<cmd>GitConflictRefresh<cr>", desc = "Refresh conflicts" },
    { ")x", "<Plug>(git-conflict-next-conflict)", desc = "Next conflict" },
    { "(x", "<Plug>(git-conflict-prev-conflict)", desc = "Previous conflict" },
    { "]x", "<Plug>(git-conflict-next-conflict)", desc = "Next conflict" },
    { "[x", "<Plug>(git-conflict-prev-conflict)", desc = "Previous conflict" },
    { "<leader>xq", "<cmd>GitConflictListQf<cr> ", desc = "List conflicts in quickfix" },
  },
  opts = {
    default_mappings = false,
  },
}

