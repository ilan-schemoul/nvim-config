-- api.sticky exposes the generic FTerm-backed helpers (config/api/sticky/fterm.lua)
-- directly, plus a nested `lazygit` submodule (config/api/sticky/lazygit.lua):
--
--   api.sticky.toggle_or_create(...)
--   api.sticky.lazygit.toggle(...)
local fterm = require('config/api/sticky/fterm')

local M = setmetatable({
  lazygit = setmetatable({}, {
    __index = function(_, key)
      return require('config/api/sticky/lazygit')[key]
    end,
  }),
}, {
  __index = fterm,
})

return M
