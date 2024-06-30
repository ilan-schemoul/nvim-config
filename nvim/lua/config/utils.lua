M = {}

M.check_libXfixes = function()
  if vim.fn.file_readable("/usr/include/X11/extensions/Xfixes.h") == 0 then
    return false
  end

  return true
end

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

M.is_intersec = function()
  return os.getenv("IS_INTERSEC") == "true"
end

M.is_not_intersec = function()
  return not M.is_intersec()
end

return M
