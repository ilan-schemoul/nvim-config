local window = require("config/api/window")

local M = {}

function M.is_listed(buffer_to_find)
  local is_listed = vim.tbl_contains(vim.api.nvim_list_bufs(), function(buffer)
    return buffer_to_find == buffer and vim.bo[buffer].buflisted
  end, { predicate = true })

  return is_listed
end

function M.is_outside_cwd()
  local path = vim.api.nvim_buf_get_name(0)
  local pwd = vim.fn.getcwd()
  -- Escape special characters from pwd so find doesn't interpret them
  pwd = pwd:gsub("%W", "%%%0")
  return vim.bo.buftype == "" and path:find(pwd) == nil
end

function M.close_if_not_last(buffer)
  -- TODO: refactor with win_findbuf
  local win = -1

  for _, w in pairs(vim.api.nvim_list_wins()) do
    local win_buffer = vim.api.nvim_win_get_buf(w)
    if win_buffer == buffer then
      win = w
    end
  end

  if win ~= -1 then
    window.close_if_not_last(win)
  end
end

function M.close_current()
  if vim.startswith(vim.fn.expand("%"), "term://") then
    -- Closing buffer without closing window
    vim.cmd("bp|sp|bn|bd!")
  else
    -- Closing buffer without closing window
    vim.cmd("bp|sp|bn|bd")
  end
  -- TODO: close buffer without closing tab
end

local function get_listed_buffers()
  return vim.tbl_filter(function(b) return vim.fn.buflisted(b) == 1 end,
                        vim.api.nvim_list_bufs())
end

-- Delete every listed buffer that is not displayed in a window
function M.close_hidden()
  local buffers = get_listed_buffers()
  for _, buffer in ipairs(buffers) do
    local open = vim.fn.bufwinnr(buffer) > 0

    if vim.api.nvim_buf_is_valid(buffer) and not open then
      -- TODO: close terminal not active
      if vim.bo[buffer].buftype ~= "terminal" and vim.bo[buffer].modified ~= 1 then
        local _, err = pcall(vim.api.nvim_buf_delete, buffer, {})

        if err then
          vim.notify(err, vim.log.levels.WARN)
        end
      end
    end
  end
end

return M
