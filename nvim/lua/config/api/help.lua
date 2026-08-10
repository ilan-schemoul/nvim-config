local M = {}

local function get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  if s_start[2] == 0 or s_end[2] == 0 then
    return nil
  end

  local region = vim.fn.getregion(s_start, s_end)
  return table.concat(region, " ")
end

-- Filetype aware help for the word under the cursor, or the visual selection if any
function M.open(word, is_visual)
  if is_visual then
    word = get_visual_selection()
  end
  word = word or vim.fn.expand("<cword>")

  if vim.bo.ft == "cs" then
    local url = "https://learn.microsoft.com/fr-fr/search/?scope=.NET&category=Documentation&terms="
    vim.cmd("!xdg-open " .. url .. word .. " &")
  elseif vim.bo.ft == "c" then
    vim.cmd(string.format('Man %s', word))
  elseif vim.bo.ft == "lua" or vim.bo.ft == "vim" then
    ---@diagnostic disable-next-line: param-type-mismatch
    local ok = pcall(vim.cmd, string.format('help %s', word))
    if not ok then
      vim.cmd(string.format('helpg %s', word))
    end
  else
    -- notify error to user
    vim.notify("No help available for this filetype", vim.log.levels.ERROR)
  end
end

return M
