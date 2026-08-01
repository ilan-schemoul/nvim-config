local M = {}

-- Returns a handler jumping to the next/previous diagnostic of an optional severity
M.jump = function(next, severity)
  local count = next and 1 or -1
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = count, severity = severity })
  end
end

return M
