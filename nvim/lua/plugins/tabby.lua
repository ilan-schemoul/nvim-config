return {
  -- "nanozuki/tabby.nvim",
  -- https://github.com/nanozuki/tabby.nvim/pull/146
  "ilan-schemoul/tabby.nvim",
  -- dir = "~/code/forks/tabby.nvim/",
  event = "VimEnter",
  dependencies = "nvim-tree/nvim-web-devicons",
  init = function()
    vim.o.showtabline = 2
  end,
  config = function()
    local Job = require("plenary.job")
    local rebase_merge = false
    local rebase_apply = false
    local current_tab_nr = -1

    local theme = {
      current = { fg = "#cad3f5", bg = "transparent", style = "bold" },
      rebase = { fg = "#6f3faf", bg = "transparent" },
      not_current = { fg = "#5b6078", bg = "transparent" },

      fill = { bg = "transparent" },
    }

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

    local function update_git_state_async()
      if current_tab_nr == -1 then
        return
      end

      local folder = vim.fn.getcwd(-1, current_tab_nr)

      Job:new({
        command = "git",
        args = { "rev-parse", "--git-path", "rebase-merge" },
        cwd = folder,
        on_stdout = function(_, line)
          if line then
            check_file_exist(folder, line, "rebase-merge")
          end
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
          if line then
            check_file_exist(folder, line, "rebase-apply")
          end
        end,
        on_exit = function(_, code)
          if code ~= 0 then
            rebase_merge = false
          end
        end,
      }):start()

      return true
    end

    local get_tab_folder = require("config/utils").get_tab_folder
    local tabby = require("tabby.tabline")

    local function init_tab()
      tabby.set(function(line)
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
              current_tab_nr = line.api.get_tab_number(tab.id)

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
      end, {
        max_refresh_ms = 200,
    })
    end

    vim.api.nvim_create_user_command("TabbyUpdate", require('tabby').update, { nargs = 0 })

    init_tab()

    local timer = vim.uv.new_timer()
    local ms = 1
    local s = 1000 * ms
    -- Tabby already rerenders frequently the tab. But if there's no activity
    -- it doesn't do anything. So we make sure AT LEAST every 10s it's refreshed.
    timer = vim.uv.new_timer()
    timer:start(0, 10 * s, vim.schedule_wrap(require("tabby").update))

    timer = vim.uv.new_timer()
    timer:start(0, 400 * ms, vim.schedule_wrap(update_git_state_async))

    timer = vim.uv.new_timer()
    timer:start(0, 1 * s, vim.schedule_wrap(function()
      local windows = vim.tbl_filter(function(win)
        local buftype = vim.bo[vim.api.nvim_win_get_buf(win)].buftype
        -- normal
        return buftype == "" or buftype == "terminal"
      end, vim.api.nvim_list_wins())

      if not require("true-zen.ataraxis").running then
        -- If there is only one window then only show tab when there are multiple tabs
        if #windows == 1 then
          vim.o.showtabline=1
          -- If there are multiple windows then show tabline even if there is only one tab
        else
          vim.o.showtabline=2
        end
      end
    end))
  end,
}
