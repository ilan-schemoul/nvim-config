return {
  init = function()
    vim.g.resurrect_ignore_patterns = { "/.git/", "^fugitive://" }
  end,
  "supercrabtree/vim-resurrect",
}
