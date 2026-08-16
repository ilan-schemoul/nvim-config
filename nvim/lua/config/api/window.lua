local M = {}

-- Close window if it is a floating window or if it is not the last opened window in the current tab
function M.close_if_not_last(window)
  window = window or vim.api.nvim_get_current_win()
  local current_win_is_floating = vim.api.nvim_win_get_config(window).relative ~= ""

  if current_win_is_floating then
    vim.api.nvim_win_close(window, false)
  else
    local windows_in_tab = vim.tbl_filter(function(win)
      local is_valid = vim.api.nvim_win_is_valid(win)
      local buf = vim.api.nvim_win_get_buf(win)
      local loaded = vim.api.nvim_buf_is_loaded(buf)
      local win_is_floating = vim.api.nvim_win_get_config(win).relative ~= ""
      return is_valid and buf and loaded and not win_is_floating
    end, vim.api.nvim_tabpage_list_wins(0))

    if #windows_in_tab > 1 then
      vim.api.nvim_win_close(window, false)
    end
  end
end

-- Open the current file in a new tab, centered between two scratch splits
function M.center(left_buffer, right_buffer)
  left_buffer = left_buffer or "new"
  right_buffer = right_buffer or "new"

  local r, c = unpack(vim.api.nvim_win_get_cursor(0))
  local width = vim.fn.winwidth(0)
  local split_width = width / 4

  -- New tab
  vim.cmd("tabedit %")

  local window = vim.api.nvim_get_current_win()
  local right_cmd = right_buffer and "belowright vs " .. right_buffer or "vert belowright new"

  -- Left buffer
  vim.cmd("vert " .. left_buffer)
  vim.cmd("vertical resize " .. split_width)
  vim.cmd("set norelativenumber | set nonumber")
  -- Disable color for current line
  vim.cmd("highlight CursorLine guifg=NONE guibg=NONE")

  vim.api.nvim_set_current_win(window)

  -- Right buffer
  vim.cmd(right_cmd .. " | vertical resize " .. split_width)
  vim.cmd("set norelativenumber | set nonumber")
  -- Disable color for current line
  vim.cmd("highlight CursorLine guifg=NONE guibg=NONE")

  vim.api.nvim_set_current_win(window)
  vim.cmd("stopinsert")
  vim.api.nvim_win_set_cursor(0, { r, c })
end

function M.close_centered()
  vim.cmd("tabclose")
  vim.cmd("tabprevious")
end

return M
