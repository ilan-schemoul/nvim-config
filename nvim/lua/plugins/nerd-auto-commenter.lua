return {
  "preservim/nerdcommenter",
  init = function()
    vim.g.NERDSpaceDelims = 1
    vim.g.NERDCustomDelimiters = {
      c = { left = '//', right = '' }
    }
    vim.g.NERDCreateDefaultMappings = 0
  end,
  keys = {
    { ",c", "<plug>NERDCommenterToggle", mode = { "n", "v" } },
    { ",c", "<plug>NERDCommenterInsert", mode = { "i" } },
  }
}
