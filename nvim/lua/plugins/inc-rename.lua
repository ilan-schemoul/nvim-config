return {
  "smjonas/inc-rename.nvim",
  opts = {},
  cmd = "IncRename",
  keys = {
    { "<leader>n", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, expr = true },
  },
}
