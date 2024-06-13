M = {}

M.get_tab_folder = function(tab_nr)
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

return M
