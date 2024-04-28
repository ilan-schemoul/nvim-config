return {
  "Bekaboo/dropbar.nvim",
  -- optional, but required for fuzzy finder support
  dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
  },
  -- Waiting on 0.10 to enable dropbar
  enabled = false,
  lazy = false,
  keys = {
    { "<leader>op", "<cmd>lua require('dropbar.api').pick()<cr>" },
  },
}
