return {
  "romgrk/barbar.nvim",
  dependencies = {
    'lewis6991/gitsigns.nvim',       -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons',   -- OPTIONAL: for file icons
  },
  -- event = { "BufReadPost", "BufNewFile" },
  -- VeryLazy = true,
  opts = {
    icons = {
      preset = 'slanted',
      filetype = {
        custom_colors = true,
      },
      gitsigns = {
        added = { enabled = true, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = true, icon = '-' },
      },
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = '🐛' },
      },
    },
  },
}
