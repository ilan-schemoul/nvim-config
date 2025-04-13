return {
  "folke/noice.nvim",
  event = "VimEnter",
  opts = {
    lsp = {
      progress = {
        enabled = false,
      },
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
    },
    messages = {
      enabled = true, -- enables the Noice messages UI
      view_error = "notify",
      view_warn = "notify", -- view for warnings
      view = "mini", -- default view for messages
      -- enabled = true,
    },
    views = {
      mini = {
        timeout = 8000,
      },
    },
    -- popupmenu = {
    --   enabled = true,
    --   backend = "nui",
    -- },
    commands = {
      history = {
        -- options for the message history that you get with `:Noice`
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {
          any = {
            {
              cond = function(_)
                return true
              end,
            },
          },
        },
      },
    },
    redirect = {
      view = "mini",
      filter = { event = "msg_show" },
    },

    routes = require("config/noice-routes"),
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = {
        fps = 2,
      },
    },
  },
}
