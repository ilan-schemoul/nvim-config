return {
  "nvim-neotest/neotest",
  dependencies = {
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-python",
    "rouge8/neotest-rust",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
        }),
        require("neotest-rust"),
      },
    })
  end,
  keys = {
    { "<leader>kf", "<cmd>lua require('neotest').run.run()<cr>", silent = true },
    { "<leader>kt", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", silent = true },
    { "<leader>ks", "<cmd>Neotest summary<cr>", silent = true },
  },
}
