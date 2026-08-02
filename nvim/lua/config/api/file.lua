local M = {}

-- Directory of the current buffer, stripping term:// style URI prefixes
function M.cwd()
  local path = vim.fn.expand('%:p:h')

  if path:find("://") then
    local _, j = path:find("://")
    path = path:sub(j + 1, path:len())
    local i, _ = path:find("//")
    -- For terminals
    if i then
      path = path:sub(1, i - 1)
    end
  end

  return vim.fn.glob(path) or path
end

-- TODO: make a pull request to the extension
local function open_from_history(is_extension)
  local history = require("telescope._extensions.smart_open.history")
  local history_result, max_score = history:get_all()
  local matched_history = {}
  local letter = vim.fn.getcharstr()

  if is_extension then
    letter = "%." .. letter
  else
    letter = "^" .. letter
  end

  -- TODO: read how smart_open does it to search faster than a manual loop + regex
  for _, v in ipairs(history_result) do
    if v.exists then
      local frecency = v.score / max_score
      local regex = ".*/(.*)"
      -- If it is not extension then we want first letter

      regex = "^" .. regex

      local _, _, file = string.find(v.path, regex)

      if string.find(file, letter) then
        table.insert(matched_history, { path = v.path, frecency = frecency })
      end
    end
  end

  table.sort(matched_history, function(a, b)
    return a.frecency < b.frecency
  end)

  if matched_history and #matched_history ~= 0 then
    vim.cmd("e " .. matched_history[#matched_history].path)
  end
end

-- Read one char, open the most frecent smart_open history file with that extension
function M.open_by_extension()
  open_from_history(true)
end

-- Read one char, open the most frecent smart_open history file starting with it
function M.open_by_first_letter()
  open_from_history(false)
end

function M.create_note()
  local dirman = require("neorg").modules.get_module("core.dirman")
  local file = vim.fn.input("File : ", "", "file")

  dirman.create_file(file, "notes", {
    no_open = false, -- open file after creation?
    force = false, -- overwrite file if exists
  })
end

return M
