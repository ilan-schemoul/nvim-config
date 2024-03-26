return {
  "romgrk/barbar.nvim",
  dependencies = {
    'lewis6991/gitsigns.nvim',       -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons',   -- OPTIONAL: for file icons
  },
  event = { "VimEnter" },
  VeryLazy = true,
  opts = {
    auto_hide = true,
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
