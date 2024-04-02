return {
  "skywind3000/asynctasks.vim",
  dependencies = {
    "skywind3000/asyncrun.vim",
  },
  init = function()
    vim.g.asyncrun_open = 6
  end,
  keys = {
    { "<leader>kr", "<cmd>AsyncTask file-run<cr>" },
    { "<leader>kb", "<cmd>AsyncTask file-build<cr>", silent = true },
    { "<leader>kc", "<C-w>o", silent = true },
  },
}
