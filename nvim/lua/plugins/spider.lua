-- Improve w/e/b by skipping punctuation
return {
  "chrisgrieser/nvim-spider",
  keys = {
      { "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" } },
      { "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" } },
      -- { "cw", "ce", mode = { "n", "o", "x" }, remap = true },
  },
  opts = {
      -- subwords is to move inside variables names (greatFriend w will go to F instead
      -- of next word). I don't want that.
      subwordMovement = false,
  },
}
