return {
  "lewis6991/gitsigns.nvim",
  cmd = "Gitsigns",
  lazy = false,
  opts = {
    numhl = false,
    signcolumn = false,
    linehl = true,
  },
  keys = {
    { "<leader>jn", "<cmd>Gitsigns toggle_numhl<cr>" },
    { "<leader>jl", "<cmd>Gitsigns toggle_linehl<cr>" },

    { "<leader>js", "<cmd>Gitsigns stage_hunk<cr>" },
    {
      "<leader>js",
      function()
        require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v",
    },

    { "<leader>jS", "<cmd>Gitsigns stage_buffer<cr>" },

    { "<leader>ju", "<cmd>Gitsigns undo_stage_hunk<cr>", mode = "n" },

    { "<leader>jR", "<cmd>Gitsigns reset_buffer<cr>" },

    { "<leader>jp", "<cmd>Gitsigns preview_hunk<cr>" },

    { "<leader>jr", "<cmd>Gitsigns reset_hunk<cr>",      mode = "n" },
    {
      "<leader>jr",
      function()
        require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v",
    },

    { "<leader>jd", "<cmd>Gitsigns diffthis<cr>" },
    { "ih",         ":<C-U>Gitsigns select_hunk<cr>", mode = { "o", "x" } },

    {
      "]c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          require("gitsigns").nav_hunk("next")
        end
      end,
    },

    {
      "[c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          require("gitsigns").nav_hunk("prev")
        end
      end,
    },

    { "<leader>jt", "<cmd>Gitsigns toggle_deleted<cr>" },
  },
}
