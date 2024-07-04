return {
  "rachartier/tiny-inline-diagnostic.nvim",
  -- https://github.com/rachartier/tiny-inline-diagnostic.nvim/issues/11
  enabled = false,
  event = "VeryLazy",
  init = function()
    vim.diagnostic.config({ virtual_text = false })
  end,
  opts = {},
}

