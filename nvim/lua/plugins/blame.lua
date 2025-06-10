return {
  -- TODO: use GitSigns blame when it will be less broken
  "FabijanZulj/blame.nvim",
  keys = {
    { "gb", ":BlameToggle<cr>" },
  },
  opts = {
    blame_options = { '-C', '-M' },
  },
}

