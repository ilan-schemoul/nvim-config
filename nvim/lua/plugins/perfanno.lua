return {
  "t-troebst/perfanno.nvim",
  config = function()
    local util = require("perfanno.util")

    require("perfanno").setup({
      line_highlights = util.make_bg_highlights("#FFFFFF", "#AA0000", 10),
      vt_highlight = util.make_fg_highlight("#AA0000"),
    })
  end
}

