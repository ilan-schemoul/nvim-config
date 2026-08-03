return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    require("notify").setup({
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 49 })
      end,
      fps = 10,
      background_colour = "#ffffff",
      merge_duplicates = false,
      stages = 'static',
    })

    vim.notify = require("notify")
  end
}
