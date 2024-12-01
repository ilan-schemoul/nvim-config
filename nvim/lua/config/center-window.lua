local function center(left_buffer, right_buffer)
  left_buffer = left_buffer or "term"
  right_buffer = right_buffer or "~/notes/memory.norg"

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
end

local function close()
  vim.cmd("tabclose")
  vim.cmd("tabprevious")
end

return {
  center = center,
  center_with_memory = center_with_memory,
  close = close,
}
