return {
  "pocco81/true-zen.nvim",
  opts = {
    modes = { -- configurations per mode
      ataraxis = {
        callbacks = { -- run functions when opening/closing Ataraxis mode
          open_post = function()
            vim.cmd("ScrollbarHide")
          end,
          close_pos = function()
            vim.cmd("ScrollbarShow")
          end,
        },
      }
    }
  },
}

