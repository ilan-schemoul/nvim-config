M = {}

M.max_treesitter_filesize = 120 * 1024 -- KB

M.buffer_is_in_tab = function(buffer_to_find)
  local is_in_tab = vim.tbl_contains(vim.api.nvim_list_bufs(), function(buffer)
    return buffer_to_find == buffer and vim.bo[buffer].buflisted
  end, { predicate = true })

  return is_in_tab
end

M.get_tab_folder = function(tab_nr)
  local success, full_path = pcall(vim.fn.getcwd, -1, tab_nr)

  if not success then
    vim.notify("Fail to get folder of tab " .. tab_nr, vim.log.levels.ERROR)
    return tostring(tab_nr)
  end

  local folder

  if full_path == vim.fn.expand('$HOME') then
    folder = "~"
  else
    _, _, folder = string.find(full_path, ".*/(.*)")

    -- Uppercase first letter
    folder = (folder:gsub("^%l", string.upper))
  end

  return folder
end

local hide_tab = false

M.set_hide_tab = function(h)
  hide_tab = h
end

M.get_hide_tab = function()
  return hide_tab
end

local separator_char = "│"
M.separator_char = separator_char

M.setup_separators = function()
  vim.cmd("set statuscolumn=" .. separator_char)
end

M.is_file_outside_pwd = function()
  local path = vim.api.nvim_buf_get_name(0)
  local pwd = vim.fn.getcwd()
  -- Escape special characters from pwd so find doesn't interpret them
  pwd = pwd:gsub("%W", "%%%0")
  return vim.bo.buftype == "" and path:find(pwd) == nil
end

M.fterm_hl = function(ft_to_hl)
  local ns_id = 1000

  vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*',
    callback = function (_)
      local hl = ft_to_hl[vim.bo.ft]

      if not hl then
        return
      end

      local window = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_hl_ns(window, ns_id)

      vim.api.nvim_set_hl(ns_id, 'FloatBorder', {
        fg = hl.border
      })

      vim.api.nvim_set_hl(ns_id, 'Normal', {
        bg = hl.bg
      })

      ns_id = ns_id + 1
    end,
  })
end

M.profile_fn = function(fn)
  return function(...)
    local start = vim.uv.hrtime()
    local ret = fn(...)
    vim.notify(("It took %.3fms"):format((vim.uv.hrtime() - start) / 1e6))

    return ret
  end
end

M.comment_above_or_below = function(lnum)
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

M.diagnostic_goto = function(next, severity)
  local count = next and 1 or -1
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = count, severity = severity })
  end
end

M.stop_recording_update_hl = function()
  vim.api.nvim_create_autocmd('RecordingLeave', {
    callback = function()
      vim.api.nvim_set_hl(0, 'CursorLineNr', {})
    end,
  })
end

return M
