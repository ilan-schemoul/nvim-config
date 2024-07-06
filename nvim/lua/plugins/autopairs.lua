return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup()

    require('cmp').event:on(
    'confirm_done',
    require('nvim-autopairs.completion.cmp').on_confirm_done()
    )
  end
}
