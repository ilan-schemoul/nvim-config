return {
  "folke/noice.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader><BS>", "<cmd>Noice dismiss<cr>" },
  },
  opts = {
    lsp = {
      progress = {
        -- enabled = false,
      },
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
    },
    messages = {
      view = "mini",
      view_error = "notify",
      enabled = true,
    },

    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          any = {

            { find = "no lines in buffer" },
            -- Edit
            { find = "%d+ less lines" },
            { find = "%d+ fewer lines" },
            { find = "%d+ more lines" },
            { find = "%d+ change;" },
            { find = "%d+ line less;" },
            { find = "%d+ more lines?;" },
            { find = "%d+ fewer lines;?" },
            { find = '".+" %d+L, %d+B' },
            { find = "%d+ lines yanked" },
            { find = "^Hunk %d+ of %d+$" },
            { find = "%d+L, %d+B$" },
            { find = "^[/?].*" }, -- Searching up/down
            { find = "E486: Pattern not found:" }, -- Searcingh not found
            { find = "%d+ changes?;" }, -- Undoing/redoing
            { find = "%d+ fewer lines" }, -- Deleting multiple lines
            { find = "%d+ more lines" }, -- Undoing deletion of multiple lines
            { find = "%d+ lines " }, -- Performing some other verb on multiple lines
            { find = "Already at newest change" }, -- Redoing
            { find = '"[^"]+" %d+L, %d+B' }, -- Saving

            -- Save
            { find = " bytes written" },

            -- Redo/Undo
            { find = " changes; before #" },
            { find = " changes; after #" },
            { find = "1 change; before #" },
            { find = "1 change; after #" },

            -- Yank
            { find = " lines yanked" },

            -- Move lines
            { find = " lines moved" },
            { find = " lines indented" },

            -- Bulk edit
            { find = " fewer lines" },
            { find = " more lines" },
            { find = "1 more line" },
            { find = "1 line less" },

            -- General messages
            { find = "Already at newest change" }, -- Redoing
            { find = "Already at oldest change" },
          },
        },
        opts = { skip = true },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
