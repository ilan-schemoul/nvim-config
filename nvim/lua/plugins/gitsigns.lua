return {
  -- autosync is enabled on my fork because the as
  "ilan-schemoul/gitsigns.nvim",
  cmd = "Gitsigns",
  event = "VimEnter",
  opts = {
    signcolumn = false,  -- Toggle with `:Gitsigns toggle_signs`
    numhl = true,
    linehl = false,
    -- NOTE: my fork adds this. The (rude) owner of the plugin refuses
    -- features so I have a gh action to sync my fork with his repo.
    staged_highlight_derivative_factor = 0.25
  },
  keys = {
    { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>" },
    {
      "<leader>gs",
      function()
        require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v",
    },

    { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>" },

    { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", mode = "n" },

    { "<leader>gd", "<cmd>Gitsigns preview_hunk<cr>" },

    { "<leader>gD", "<cmd>DiffviewOpen<cr>" },

    { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", mode = "n" },

    { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>" },

    { "<leader>gh", "<cmd>Gitsigns change_base<cr>" },
    { "<leader>gp", "<cmd>Gitsigns change_base HEAD~<cr>" },

    {
      "<leader>gr",
      function()
        require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v",
    },

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
  },
}
