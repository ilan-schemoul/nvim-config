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

    local function get_tab_folder(tab_nr)
        local success, full_path = pcall(vim.fn.getcwd, -1, tab_nr)

        if not success then
            return tostring(tab_nr)
        end

        if full_path == vim.fn.expand('$HOME') then
            return "~"
        end

        local _, _, folder = string.find(full_path, ".*/(.*)")

        -- Uppercase first letter
        folder = (folder:gsub("^%l", string.upper))

        return folder
    end

    local function update_tab()
        require("tabby.tabline").set(function(line)
            return {
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
                line.spacer(),
                line.tabs().foreach(function(tab)
                    local hl = tab.is_current() and theme.current or theme.not_current
                    return {
                        line.sep(" ", hl, theme.fill),
                        get_tab_folder(line.api.get_tab_number(tab.id)),
                        line.sep(" ", hl, theme.fill),
                        hl = hl,
                    }
                end),

                hl = theme.fill,
            }
        end, {
        tab_name = {
            name_fallback = function(tabid)
                return get_tab_folder(tabid)
            end
        }
    })
    end

    local timer = vim.uv.new_timer()
    timer:start(0, 3 * 1000, vim.schedule_wrap(update_tab))
end,
}
