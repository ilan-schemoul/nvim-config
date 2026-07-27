return {
  "rcarriga/nvim-notify",
  event = "BufEnter",
  config = function()
    require("notify").setup({
      fps = 10,
      background_colour = "#ffffff",
      merge_duplicates = false,
      stages = 'static'
    })

    vim.notify = require("notify")
  end
}
