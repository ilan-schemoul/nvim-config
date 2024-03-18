return {
  "mg979/vim-visual-multi",
  keys = {
    { "<C-j>", "<cmd>call vm#commands#add_cursor_down(0, v:count1)<cr>" },
    { "<C-k>", "<cmd>call vm#commands#add_cursor_up(0, v:count1)<cr>" },
  }

}
