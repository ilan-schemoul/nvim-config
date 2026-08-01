-- Every internal helper of this config lives under `config/api/<topic>.lua`.
--
--   local api = require('config/api')
--   api.ui.set_separator_statuscolumn()
--
-- Submodules are loaded on first access so that plugin specs requiring
-- `config/api` at lazy.nvim spec-load time stay cheap.
--
-- Submodules must require each other directly (`require('config/api/sticky')`),
-- never through this file.
local modules = {
  'ast_grep', 'buffer', 'claude', 'smelly_sunflower', 'diagnostics', 'file',
  'git', 'help', 'job', 'keymap', 'lsp', 'sticky', 'tab', 'terminal', 'text',
  'ui', 'window',
}

local api = {}

for _, name in ipairs(modules) do
  api[name] = setmetatable({}, {
    __index = function(_, key)
      return require('config/api/' .. name)[key]
    end,
  })
end

return api
