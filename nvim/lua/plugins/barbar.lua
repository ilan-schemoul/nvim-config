return {
  "romgrk/barbar.nvim",
  -- event = { "BufReadPost", "BufNewFile" },
  -- VeryLazy = true,
  opts = {
    icons = {
      preset = 'slanted',
      filetype = {
        custom_colors = true,
      },
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = '🐛' },
      },
    },
  },
}
