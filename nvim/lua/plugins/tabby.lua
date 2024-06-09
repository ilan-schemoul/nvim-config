return {
  "nanozuki/tabby.nvim",
  event = "VimEnter",
  dependencies = "nvim-tree/nvim-web-devicons",
  init = function()
    vim.o.showtabline = 2
  end,
  config = function()
    local git_state = "none"
    local Job = require("plenary.job")
    local rebase_merge = false
    local rebase_apply = false

    local theme = {
      current = { fg = "#cad3f5", bg = "transparent", style = "bold" },
      rebase = { fg = "#6f3faf", bg = "transparent" },
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

    local function check_file_exist(folder, line, check)
        Job:new({
            command = "test",
            args = { "-d", line },
            cwd = folder,
            on_exit = function(_, code)
                if check == "rebase-merge" then
                    rebase_merge = code == 0
                elseif check == "rebase-apply" then
                    rebase_apply = code == 0
                end
            end,
        }):start()
    end

    local function update_git_state_async(tab_nr)
        local folder = vim.fn.getcwd(-1, tab_nr)

        Job:new({
            command = "git",
            args = { "rev-parse", "--git-path", "rebase-merge" },
            cwd = folder,
            on_stdout = function(_, line)
                check_file_exist(folder, line, "rebase-merge")
            end,
            on_exit = function(_, code)
                if code ~= 0 then
                    rebase_merge = false
                end
            end,
        }):start()

        Job:new({
            command = "git",
            args = { "rev-parse", "--git-path", "rebase-apply" },
            cwd = folder,
            on_stdout = function(_, line)
                check_file_exist(folder, line, "rebase-apply")
            end,
            on_exit = function(_, code)
                if code ~= 0 then
                    rebase_merge = false
                end
            end,
        }):start()
        return true
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
                    local hl

                    if tab.is_current() then
                        local tab_nr = line.api.get_tab_number(tab.id)
                        update_git_state_async(tab_nr)

                        if rebase_merge or rebase_apply then
                            hl = theme.rebase
                        else
                            hl = theme.current
                        end
                    else
                        hl = theme.not_current
                    end

                    return {
                        line.sep(" ", hl, theme.fill),
                        get_tab_folder(line.api.get_tab_number(tab.id)),
                        line.sep(" ", hl, theme.fill),
                        hl = hl,
                    }
                end),

                hl = theme.fill,
            }
        end)
    end

    update_tab()

    vim.api.nvim_create_user_command("TabbyUpdate", update_tab, { nargs = 0 })

    local timer = vim.uv.new_timer()
    local ms = 1
    timer:start(0, 300 * ms, vim.schedule_wrap(update_tab))
end,
}
