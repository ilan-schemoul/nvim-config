return {
  "t-troebst/perfanno.nvim",
  -- There is much more Perf functions but I'm too lazy to type them all
  -- But lazy is important because otherwise we have to load the slow Telescope
  cmd = {
    "PerfLuaProfileStart",
  },
  config = function()
    local util = require("perfanno.util")

    require("perfanno").setup({
      line_highlights = util.make_bg_highlights("#FFFFFF", "#AA0000", 10),
      vt_highlight = util.make_fg_highlight("#AA0000"),
    })
  end
}

