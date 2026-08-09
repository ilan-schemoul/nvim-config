local M = {}

--XXX:de
-- Wrap a function so calling it notifies how long it took
function M.profile(fn)
  return function(...)
    local start = vim.uv.hrtime()
    local ret = fn(...)
    vim.print(("It took %.3fms"):format((vim.uv.hrtime() - start) / 1e6))

    return ret
  end
end

return M
