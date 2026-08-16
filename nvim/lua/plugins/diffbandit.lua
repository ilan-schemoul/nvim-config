-- Used for conflicts <leader>dx and possibly to see file history <leader>dg => file history
return {
  "CoreyKaylor/diffbandit.nvim",

  cmd = {
    -- Compare two files
    "DiffBandit",
    -- Compare two folders
    "DiffBanditFolderDiff",

    -- Compare two buffers
    "DiffBanditBuffers",

    -- Compare all diff of repo
    "DiffBanditGit", -- all files
    "DiffBanditGitCurrent", -- current file

    -- Commit (unused)
    "DiffBanditCommitPanel",
    "DiffBanditToggleStageHunk",
    "DiffBanditStageHunk",
    "DiffBanditUnstageHunk",
    "DiffBanditDiscardHunk",
    "DiffBanditApplyLeftHunk",
    "DiffBanditApplyRightHunk",
    "DiffBanditUndo",

    "DiffBanditGitMenu",
    "DiffBanditGitLog",
    "DiffBanditGitCommit",
    "DiffBanditGitCompare",
    "DiffBanditGitCheckout",

    -- Merge/rebase conflict (most useful)
    "DiffBanditMerge",
  },

  keys = {
    { "<leader>dg", "<cmd>DiffBanditGitMenu<cr>" },
    { "<leader>dc", "<cmd>DiffBanditCommitPanel<cr>" },
    { "<leader>dx", "<cmd>DiffBanditMerge<cr>" },
    { "<leader>dm", "<cmd>DiffBanditMerge<cr>" },
    { "<leader>dt", "<cmd>DiffBandit /tmp/a /tmp/b<cr>" },
  },
  opts = {
    ui = {
      connector_width = 1,
      connector_max_width = 1,
    },
    -- Conflict (only real usage)
    merge = {
      keys = {
        next_conflict = "]x",
        prev_conflict = "[x",

        -- Also equivalent defined in mappings
        accept_local = "<leader>dl",
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

    git = {
      panel = {
        keys = {
          toggle_stage = "<leader>ds",
          focus_diff = "<CR>",
          focus_panel = "<leader>dp",
          focus_commit = "<leader>dc",
          file_actions = "<leader>df",
          toggle_amend = "<leader>da",
          refresh = "<leader>dr",
          close = "q",
        },
      },
    },
    -- Not properly configured yet (no usage as for now)
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

