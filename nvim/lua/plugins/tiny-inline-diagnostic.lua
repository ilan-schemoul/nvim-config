-- Cool plugins to see LSP warnings/errors in the file
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "NormalBufferEnter",
  setup = function(opts)
    require('tiny-inline-diagnostic').setup(opts)
  end,
  opts = {
    options = {
        multilines = true,
    },
  },
}

