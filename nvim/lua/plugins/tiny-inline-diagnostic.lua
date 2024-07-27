return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  init = function()
    vim.diagnostic.config({ virtual_text = false })
  end,
  opts = {
    options = {
        multilines = true,
    },
  },
}

