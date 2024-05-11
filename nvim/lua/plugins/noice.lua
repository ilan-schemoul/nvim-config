return {
  "folke/noice.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader><BS>", "<cmd>Noice dismiss<cr>" },
  },
  init = function()
    require("telescope").load_extension("noice")
  end,
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
    popupmenu = {
      enabled = true,
      backend = "cmp",
    },
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
    presets = { inc_rename = true },

    routes = {
      {
        event = "notify",
        kind = "",
        filter = {
          any = {
            { find = "E486" },
            { find = "search hit" },
          },
        },
        view = "mini",
      },
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
  config = function(_, opts)
    vim.cmd([[
        let output = system("cd $(readlink ~/.config/nvim) && git status --porcelain")
        let g:seed = srand()

        if output != ""
            lua require("notify")("The nvim git repository is out of sync (must commit/push or pull)", "warn")
        endif
    ]])

    require("noice").setup(opts)
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
