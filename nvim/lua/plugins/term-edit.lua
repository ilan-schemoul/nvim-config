-- To edit a command in the terminal in normal mode (ciw etc. works most of the time)
return {
  'chomosuke/term-edit.nvim',
  -- NOTE: extremely buggy if it is lazy loaded (when you start a terminal everything is weird)
  lazy = false,
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
