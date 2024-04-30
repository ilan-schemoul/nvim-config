return {
  "nanozuki/tabby.nvim",
  event = "VimEnter",
  dependencies = "nvim-tree/nvim-web-devicons",
  init = function()
    vim.o.showtabline = 2
  end,
  config = function()
    local theme = {
      current = { fg = "#cad3f5", bg = "transparent", style = "bold" },
      not_current = { fg = "#5b6078", bg = "transparent" },

      fill = { bg = "transparent" },
    }

    require("tabby.tabline").set(function(line)
      return {
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current or theme.not_current
          return {
            line.sep(" ", hl, theme.fill),
            tab.name(),
            line.sep(" ", hl, theme.fill),
            hl = hl,
          }
        end),
        line.spacer(),
        {
            vim.fn.strftime("%H:%M"),
            hl = { fg = "#a9adbe" }
        },
        line.spacer(),
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
          local hl = win.is_current() and theme.current or theme.not_current

          return {
            line.sep(" ", hl, theme.fill),
            win.buf_name(),
            line.sep(" ", hl, theme.fill),
            hl = hl,
          }
        end),
        hl = theme.fill,
      }
    end)
  end,
}
