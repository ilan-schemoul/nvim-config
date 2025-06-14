return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
  },
  opts = {
    view = {
      merge_tool = {
        layout = "diff4_mixed",
        disable_diagnostics = true,   -- Temporarily disable diagnostics for diff buffers while in the view.
        winbar_info = true,           -- See |diffview-config-view.x.winbar_info|
      },
    }
  },
}

