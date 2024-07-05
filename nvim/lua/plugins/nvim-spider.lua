return {
  "chrisgrieser/nvim-spider",
  keys = {
      { "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" } },
      { "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" } },
      { "cw", "ce", mode = { "n", "o", "x" }, remap = true },
  },
  opts = {
      subwordMovement = false,
  },
}
