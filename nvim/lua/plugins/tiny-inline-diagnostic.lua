-- Cool plugins to see LSP warnings/errors in the file
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

