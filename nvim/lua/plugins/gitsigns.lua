local spec = {
  "lewis6991/gitsigns.nvim",
  cmd = "Gitsigns",
  event = "NormalBufferEnter",
  opts = {
    signcolumn = true,
    numhl = false,
    linehl = false,
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_', show_count = true },
      topdelete    = { text = '‾', show_count = true },
      changedelete = { text = '~', show_count = true },
      untracked    = { text = '┆' },
    },
    signs_staged = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_', show_count = true },
      topdelete    = { text = '‾', show_count = true },
      changedelete = { text = '~', show_count = true },
      untracked    = { text = '┆' },
    },
    count_chars = {
      "",
      "²",
      "³",
      "⁴",
      "⁵",
      "⁶",
      "⁷",
      "⁸",
      "⁹",
      ["+"] = ">"
    }
  },
  keys = {
    { "gb", "<cmd>Gitsigns blame<cr>", desc = "Toggle git blame" },
    { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
    {
      "<leader>gs",
      function()
        require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v",
      desc = "Stage hunk",
    },

    { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage buffer" },

    { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", mode = "n", desc = "Undo stage hunk" },

    { "<leader>gd", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
    { "<leader>gi", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Preview hunk inline" },

    { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },

    { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", mode = "n", desc = "Reset hunk" },

    { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset buffer" },

    { "<leader>gh", "<cmd>Gitsigns change_base<cr>", desc = "Change diff base" },
    { "<leader>gp", "<cmd>Gitsigns change_base HEAD~1<cr>", desc = "Change diff base to HEAD~1" },

    { "<leader>gP", ":Gitsigns change_base HEAD~", desc = "Change diff base to HEAD~N" },

    {
      'ih',
      function()
        require("gitsigns").select_hunk()
      end,
      mode = { 'o', 'x' },
      desc = "Select hunk",
    },

    {
      "<leader>gr",
      function()
        require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v",
      desc = "Reset hunk",
    },

    {
      ")c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ ")c", bang = true })
        else
          require("gitsigns").nav_hunk("next")
        end
      end,
      desc = "Next hunk",
    },

    {
      "(c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "(c", bang = true })
        else
          require("gitsigns").nav_hunk("prev")
        end
      end,
      desc = "Previous hunk",
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
      desc = "Next hunk",
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
      desc = "Previous hunk",
    },

    {
      'gQ', function() require('gitsigns').setqflist('all') end
    },

    {
      'gq', function() require('gitsigns').setqflist() end,
    },
  },
}

for i = 1, 9 do
  table.insert(spec.keys, {
    "<leader>g" .. i .. "p",
    function() require("gitsigns").change_base("HEAD~" .. i) end,
    desc = "Change diff base to HEAD~" .. i,
  })
end

return spec
