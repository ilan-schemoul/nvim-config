return {
  "Bekaboo/dropbar.nvim",
  -- optional, but required for fuzzy finder support
  dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
  },
  enabled = true,
  lazy = false,
  keys = {
    { "<leader>op", "<cmd>lua require('dropbar.api').pick()<cr>" },
  },
}
