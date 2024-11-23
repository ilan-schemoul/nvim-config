-- FIXME: when I leave zen mode instead of restoring current tab it goes to the
-- next one
return {
  -- "pocco81/true-zen.nvim",
  -- dir = "~/code/forks/true-zen.nvim",
  -- https://github.com/pocco81/true-zen.nvim/pull/138
  -- https://github.com/pocco81/true-zen.nvim/pull/136
  "ilan-schemoul/true-zen.nvim",
  keys = {
    { "<leader>z", "<cmd>TZAtaraxis<cr>" }
  },
  opts = {
    modes = { -- configurations per mode
      ataraxis = {
        shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
        padding = { -- padding windows
          left = 38,
          right = 38,
        },
        quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
        callbacks = { -- run functions when opening/closing Ataraxis mode
          open_pos = function()
            vim.cmd("ScrollbarHide")
            vim.cmd("setl nonumber")
            vim.cmd("setl norelativenumber")
          end,
          close_pos = function()
            vim.cmd("ScrollbarShow")
            vim.cmd("setl number")
            vim.cmd("setl relativenumber")
          end,
        },
      }
    }
  },
}

