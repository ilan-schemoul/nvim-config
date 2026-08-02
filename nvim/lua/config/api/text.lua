local M = {}

function M.visual_selection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

-- Insert an empty comment `lnum` lines away from the cursor and start typing in it
function M.insert_comment_line(lnum)
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local comment_row = row + lnum
  local l_cms, r_cms = string.match(vim.bo.commentstring, '(.*)%%s(.*)')
  l_cms = vim.trim(l_cms)
  r_cms = vim.trim(r_cms)
  if #r_cms ~= 0 then
    r_cms = ' ' .. r_cms
  end
  vim.api.nvim_buf_set_lines(0, comment_row, comment_row, false, { l_cms .. ' ' .. r_cms})
  vim.api.nvim_win_set_cursor(0, { comment_row + 1, 0 })
  vim.api.nvim_command('normal! ==')
  vim.api.nvim_win_set_cursor(0, { comment_row + 1, #vim.api.nvim_get_current_line() - #r_cms - 1 })
  vim.api.nvim_feedkeys('a', 'ni', true)
end

return M
