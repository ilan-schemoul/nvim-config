local M = {}

-- Filetype aware help for the word under the cursor
function M.open(word)
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
