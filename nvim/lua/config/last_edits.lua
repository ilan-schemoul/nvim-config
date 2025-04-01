local M = {}
LAST_EDITS = {}
local edits_idx = 1
local MAX_EDITS = 3

local get_txt = function()
    local bufnr = vim.fn.bufnr('%')  -- Get the current buffer number
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local buffer_text = table.concat(lines, "\n")
    return buffer_text
end
local old = ""

local add = function(last_edit)
  if #last_edit <= 1 then
    return
  end

  -- Shift all elements to the right
  for i, _ in ipairs(LAST_EDITS) do
    if i < MAX_EDITS then
      LAST_EDITS[i + 1] = LAST_EDITS[i]
    end
  end

  LAST_EDITS[1] = last_edit
end

local function get_inserted_text(old, new)
  old_lines = {}
  for s in old:gmatch("[^\r\n]+") do
      table.insert(old_lines, s)
  end
  new_lines = {}
  for s in new:gmatch("[^\r\n]+") do
      table.insert(new_lines, s)
  end
  local diff = ""
  for i, l in ipairs(new_lines) do
    if l ~= old_lines[i] then
      if #l > 5 then
        diff = diff .. l .. "\n"
      end
    end
  end
  return diff
end

M.auto = function()
  vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    callback = function()
      if vim.bo.buftype ~= "" then
        return
      end
      old = get_txt()
    end,
  })

  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
      if vim.bo.buftype ~= "" then
        return
      end

      if #old > 0 then
        add(get_inserted_text(old, get_txt()))
      end
    end,
  })
end

M.get_last_edits = function()
  local str = ""
  for i, cur_last_edit in ipairs(LAST_EDITS) do
    str = str .. "[USER_EDIT]" .. cur_last_edit
  end
  return str
end


M.get_qwen_last_edits = function()
  local str = ""
  for i, cur_last_edit in ipairs(LAST_EDITS) do
    str = str .. "<|user_edit|> " .. str .. cur_last_edit
  end

  return str
end

return M
