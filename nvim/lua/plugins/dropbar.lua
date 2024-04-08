return {
  "Bekaboo/dropbar.nvim",
  -- optional, but required for fuzzy finder support
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  enabled = false,
  lazy = false,
  keys = {
    { "<leader>p", "<cmd>lua require('dropbar.api').pick()<cr>" },
  },
}
