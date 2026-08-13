return {
  "CoreyKaylor/diffbandit.nvim",
  keys = {
    { "<leader>dg", "<cmd>DiffBanditGitMenu<cr>" },
    { "<leader>dc", "<cmd>DiffBanditCommitPanel<cr>" },
    { "<leader>dx", "<cmd>DiffBanditMerge<cr>" },
    { "<leader>dm", "<cmd>DiffBanditMerge<cr>" }
  },
  opts = {
    git = {
      panel = {
        keys = {
          toggle_stage = "<leader>ds",
          focus_diff = "<CR>",
          focus_panel = "<leader>dp",
          focus_commit = "<leader>dc",
          file_actions = "<leader>df",
          toggle_amend = "<leader>ds",
          refresh = "<leader>dr",
          close = "q",
        },
      },
    },
    merge = {
      keys = {
        next_conflict = "]c",
        prev_conflict = "[c",
        accept_local = "<leader>d",
        accept_remote = "<leader>dr",
        accept_both = "<leader>db",
        apply_non_conflicting = "<leader>da",
        focus_panel = "<leader>dp",
        snap = "]s",
        toggle_panel = "<leader>dP",
        toggle_local = "<leader>dL",
        toggle_remote = "<leader>dR",
        show_all = "<leader>dA",
        close = "q",
      },
    },
    folder = {
      keys = {
        open = "<CR>",
        alternate_open = "o",
        toggle_expand = "<Space>",
        alternate_toggle_expand = "za",
        expand_all = "zR",
        collapse_all = "zM",
        next_diff = "]c",
        prev_diff = "[c",
        refresh = "R",
        filter = "s",
        close = "q",
      },
    },
  },
}

