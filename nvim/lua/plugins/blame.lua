return {
  -- TODO: use GitSigns blame when it will be less broken
  "FabijanZulj/blame.nvim",
  keys = {
    { "gb", ":BlameToggle<cr>" },
  },
  opts = {
    -- -C follows lines moved/copied from other files modified in the same commit
    -- -M follows moved or copied lines within a file
    blame_options = { '-C', '-M' },
  },
}

