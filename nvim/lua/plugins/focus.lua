return {
  "nvim-focus/focus.nvim",
  opts = {
    autoresize = {
      enable = false,
    },
    ui = {
      signcolumn = false,
      hybridnumber = true,
      absolutenumber_unfocussed = true,
    },
  },
  config = function(_, opts)
    require("focus").setup(opts)
  end,
}
