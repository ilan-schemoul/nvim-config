return {
  "mg979/vim-visual-multi",
  lazy = false,
  init = function()
     vim.cmd([[
        let g:VM_default_mappings = 0
        let g:VM_mouse_mappings = 1
     ]])
  end,
  keys = {
    { "<C-j>", "<cmd>call vm#commands#add_cursor_down(0, v:count1)<cr>" },
    { "<C-k>", "<cmd>call vm#commands#add_cursor_up(0, v:count1)<cr>" },
  },
}
