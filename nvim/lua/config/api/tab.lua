local M = {}

-- Capitalized basename of the tab's cwd ("~" for $HOME)
function M.folder_name(tab_nr)
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

local hidden = false

function M.set_hidden(h)
  hidden = h
end

function M.is_hidden()
  return hidden
end

return M
