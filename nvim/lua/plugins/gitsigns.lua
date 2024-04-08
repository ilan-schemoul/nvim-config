return {
  "lewis6991/gitsigns.nvim",
  cmd = "Gitsigns",
  keys = {
    { "<leader>jn", "<cmd>Gitsigns toggle_numhl<cr>" },
    { "<leader>jt", "<cmd>Gitsigns toggle_numhl<cr>" },
    { "<leader>jh", "<cmd>Gitsigns toggle_linehl<cr>" },
    { "<leader>ju", "<cmd>Gitsigns undo_stage_hunk<cr>", mode = "n" },
    { "<leader>js", "<cmd>Gitsigns stage_hunk<cr>" },
    {
      "<leader>js",
      function()
        require('gitsigns').stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v",
    },
    { "<leader>jr", "<cmd>Gitsigns reset_hunk<cr>", mode = "n" },
    { "<leader>jR", "<cmd>lua require('gitsigns').reset_hunk {vim.fn.line('.'), vim.fn.line('v')}<cr>", mode = "n" },
    {
      "<leader>jr",
      function()
        require('gitsigns').reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v",
    },
    { "<leader>jp", "<cmd>Gitsigns preview_hunk<cr>" },
  },
  opts = {
    signcolumn = false,
    numhl = false,
  },
}
