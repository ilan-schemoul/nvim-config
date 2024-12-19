return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      opts = 2,
    })

    vim.notify = require("notify")
  end
}
