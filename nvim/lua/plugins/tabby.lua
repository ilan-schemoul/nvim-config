local Job = require("plenary.job")
local rebase_merge = false
local rebase_apply = false
-- Tabby loads this list. Then update_branch_async asynchronously for each id
-- of this list update the dict branches which is then used by tabby.
local tab_ids = {}
local branches = {}
local ms = 1

local function hide_tabs_when_possible()
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
end

local function update_branch_async(pattern_replace_branch)
  for _, tab_id in pairs(tab_ids) do
    local tab_nr = vim.api.nvim_tabpage_get_number(tab_id)
    local folder = vim.fn.getcwd(-1, tab_nr)

    if folder:find(pattern_replace_branch) ~= nil then
      Job:new({
        command = "git",
        args = { "rev-parse", "--abbrev-ref", "HEAD" },
        cwd = folder,
        on_stdout = function(_, branch_name)
          -- Do not do branches = {}.
          if branch_name ~= "HEAD" then
            branches[tab_id] = branch_name
          end
        end,
        on_exit = function(_, exit_code)
          if exit_code ~= 0 then
            -- X[Y] = nil deletes the element
            branches[tab_id] = nil
          end
        end
      }):start()
    else
      branches[tab_id] = nil
    end
  end
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

local function update_git_state_async()
  local cwd = vim.fn.getcwd()

  Job:new({
    command = "git",
    args = { "rev-parse", "--git-path", "rebase-merge" },
    cwd = cwd,
    on_stdout = function(_, line)
      if line then
        check_file_exist(cwd, line, "rebase-merge")
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
    cwd = cwd,
    on_stdout = function(_, line)
      if line then
        check_file_exist(cwd, line, "rebase-apply")
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

local function is_file_outside_pwd()
  local path = vim.api.nvim_buf_get_name(0)
  local pwd = vim.fn.getcwd()
  -- Escape special characters from pwd so find doesn't interpret them
  pwd = pwd:gsub("%W", "%%%0")
  return vim.bo.buftype == "" and path:find(pwd) == nil
end

return {
  "nanozuki/tabby.nvim",
  event = "VimEnter",
  dependencies = "nvim-tree/nvim-web-devicons",
  init = function()
    vim.o.showtabline = 2
  end,
  config = function()
    local pattern_replace_branch = "mmsx\\-.*"

    local theme = {
      current = { fg = "#cad3f5", bg = "transparent", style = "bold" },
      rebase = { fg = "#9f54ec", bg = "transparent" },
      not_current = { fg = "#5b6078", bg = "transparent" },
      outside_pwd = { fg = "#fd0000", bg = "transparent" },
      jump_mode = { fg = "#fd0000", bg = "transparent" },

      fill = { bg = "transparent" },
    }

    local get_tab_folder = require("config/utils").get_tab_folder
    local tabby = require("tabby.tabline")

    local function init_tab()
      tabby.set(function(line)
        -- WARN: I could do tab_ids = {} but I think it's sometimes not safe if it's a
        -- global variable
        -- WARN: Only use pairs because we us tab_ids not as array but as hashmap
        for k in pairs (tab_ids) do
          tab_ids[k] = nil
        end
        line.tabs().foreach(function(tab)
          table.insert(tab_ids, tab.id)
        end)

        return {
          {
            vim.fn.strftime("%H:%M"),
            hl = { fg = "#a9adbe" }
          },
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            local hl = {}

            if not win.is_current() then
              hl = theme.not_current
            elseif is_file_outside_pwd() then
              hl = theme.outside_pwd
            elseif rebase_merge or rebase_apply then
              hl = theme.rebase
            elseif win.is_current() then
              hl = theme.current
            else
              assert(false)
            end

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
              tab.jump_key(),
              tab.in_jump_mode() and " " or "",
              branches[tab.id] and "󰘬" or "",
              tab.name(),
              line.sep(" ", hl, theme.fill),

              hl = hl,
            }
          end),

          hl = theme.fill,
        }
      end, {
      tab_name = {
        override = function(tab_id)
          -- Branches[id] is only set when the path pattern_replace_branch
          -- is matched by the cwd of a tab.
          if branches[tab_id] ~= nil then
            return branches[tab_id]
          else
            local tab_nr = vim.api.nvim_tabpage_get_number(tab_id)
            return get_tab_folder(tab_nr)
          end
        end
      }
    })
    end

    vim.api.nvim_create_user_command("TabbyUpdate", require('tabby').update, { nargs = 0 })

    init_tab()

    -- Starting everything at different times so everything don't run at the same
    -- time
    local timer_1 = vim.uv.new_timer()
    timer_1:start(0 * ms, 400 * ms, vim.schedule_wrap(update_git_state_async))

    -- PERF: Heavy as it 0(n) where n in the number of tabs
    local timer_2 = vim.uv.new_timer()
    timer_2:start(10 * ms, 1200 * ms, vim.schedule_wrap(function()
      update_branch_async(pattern_replace_branch)
    end))

    local timer_3 = vim.uv.new_timer()
    timer_3:start(20 * ms, 400 * ms, vim.schedule_wrap(hide_tabs_when_possible))

    -- Starts later so everything is already up to date when the function runs
    local timer_4 = vim.uv.new_timer()
    timer_4:start(200 * ms, 400 * ms, vim.schedule_wrap(require("tabby").update))
  end,
}
