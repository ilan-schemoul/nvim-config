return {
  "akinsho/git-conflict.nvim",
  lazy = false,
  keys = {
    { "<leader>xo", "<cmd>GitConflictChooseOurs<cr>" },
    { "<leader>xt", "<cmd>GitConflictChooseTheirs<cr>" },
    { "<leader>xb", "<cmd>GitConflictChooseBoth<cr>" },
    { "<leader>xn", "<cmd>GitConflictChooseNone<cr>" },
    { "<leader>xr", "<cmd>GitConflictRefresh<cr>" },
    { "]x", "<cmd>GitConflictNextConflict<cr>" },
    { "[x", "<cmd>GitConflictPrevConflict<cr>" },
    { "<leader>xq", "<cmd>GitConflictListQf<cr> " },
  },
  opts = {
    default_mappings = false,
  },
}

