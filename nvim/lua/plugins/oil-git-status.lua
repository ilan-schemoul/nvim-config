return {
  "refractalize/oil-git-status.nvim",
  dependencies = {
    "stevearc/oil.nvim",
  },
  config = function()
    require('oil-git-status').setup()

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "oil" then
          vim.cmd('set statuscolumn=')
        elseif vim.bo.buftype == '' then
          require("config/utils").setup_separators()
        end
      end,
    })
  end,
}

