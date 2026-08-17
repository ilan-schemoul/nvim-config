return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  init = function()
    vim.g.mkdp_auto_close = 0
  end,
  ft = { "markdown" },
  build = ":call mkdp#util#install()",
}
