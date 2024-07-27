return {
  "nvim-focus/focus.nvim",
  opts = {
    autoresize = {
      enable = false,
    },
    split = {
      bufnew = true,
    },
    ui = {
      signcolumn = false,
      hybridnumber = true,
      absolutenumber_unfocussed = true,
    },
  },
  config = function(_, opts)
    require("focus").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "true_zen_padding_window",
        callback = function()
          vim.b.focus_disable = true
        end
    })
  end,
}
