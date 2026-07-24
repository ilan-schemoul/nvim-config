return {
  "rcarriga/nvim-notify",
  event = "BufEnter",
  config = function()
    require("notify").setup({
      opts = 2,
      background_colour = "#ffffff",
      merge_duplicates = false
    })

    vim.notify = require("notify")
  end
}
