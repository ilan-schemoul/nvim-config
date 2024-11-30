local center = {}

function center.focus()
  local width = vim.fn.winwidth(0)
  local split_width = width / 2

  -- New tab
  vim.cmd("tabedit %")

  local window = vim.api.nvim_get_current_win()

  -- Right buffer
  vim.cmd("vert belowright new | vertical resize " .. split_width)
  vim.cmd("set norelativenumber | set nonumber")
  -- Disable color for current line
  vim.cmd("highlight CursorLine guifg=NONE guibg=NONE")

  vim.api.nvim_set_current_win(window)

  -- Left buffer
  vim.cmd("vert new | vertical resize " .. split_width)
  vim.cmd("set norelativenumber | set nonumber")
  -- Disable color for current line
  vim.cmd("highlight CursorLine guifg=NONE guibg=NONE")

  vim.api.nvim_set_current_win(window)
end

function center.close()
  vim.cmd("tabclose")
  vim.cmd("tabprevious")
end

return center
