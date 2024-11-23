-- You can do f{char} with vim. E.g fa to go to character a in same line.
-- This plugins makes f/t/F/T/;/, works multilines (and some other stuff)
return {
  "backdround/improved-ft.nvim",
  keys = { "f", "t", "F", "T", ";", "," },
  opts = {
    use_default_mappings = true,
  },
}

