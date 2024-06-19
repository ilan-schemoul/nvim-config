return {
  'chomosuke/term-edit.nvim',
  lazy = false, -- or ft = 'toggleterm' if you use toggleterm.nvim
  version = '1.*',
  opts = {
    prompt_end = '> ',
    mapping = {
      n = {
        p = false,
        P = false,
        ["\"+p"] = false,
      }
    },
  }
}
