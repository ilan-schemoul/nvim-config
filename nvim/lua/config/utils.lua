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

M.is_intersec = function()
  return os.getenv("IS_INTERSEC") == "true"
end

local hide_tab = false

M.set_hide_tab = function(h)
  hide_tab = h
end

M.get_hide_tab = function()
  return hide_tab
end

return M
