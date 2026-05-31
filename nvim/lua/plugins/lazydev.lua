return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- Or relative, which means they will be resolved from the plugin dir.
      "lazy.nvim",
      "nvim-dap-ui",
    },
  },
}
