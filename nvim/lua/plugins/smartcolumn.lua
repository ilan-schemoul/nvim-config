return {
  "m4xshen/smartcolumn.nvim",
  opts = {
    custom_colorcolumn = function ()
      return tostring(vim.bo.textwidth)
    end
  },
}

