return {
  "shortcuts/no-neck-pain.nvim",
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "no-neck-pain",
      callback = function()
        vim.b.focus_disable = true
        vim.b.nonumber = 1;
      end
    })
  end,
  opts = {
    killAllBuffersOnDisable = true,
  },
  keys = {
    { "<leader>z", "<Cmd>NoNeckPain<CR>" }
  },
}
