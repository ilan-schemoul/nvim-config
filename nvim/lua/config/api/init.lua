-- Every internal helper of this config lives under `config/api/<topic>.lua`.
--
--   local api = require('config/api')
--   api.ui.set_separator_statuscolumn()
--
-- Submodules are loaded on first access so that plugin specs requiring
-- `config/api` at lazy.nvim spec-load time stay cheap.
--
-- The `---@module` annotations are what let lua_ls resolve completion,
-- hover and go-to-definition through the lazy proxies. Keep one per field.
--
-- Submodules must require each other directly (`require('config/api/sticky')`),
-- never through this file.

---@param name string
local function lazy(name)
  return setmetatable({}, {
    __index = function(_, key)
      return require('config/api/' .. name)[key]
    end,
  })
end

local api = {}

---@module 'config.api.ast_grep'
api.ast_grep = lazy('ast_grep')
---@module 'config.api.buffer'
api.buffer = lazy('buffer')
---@module 'config.api.claude'
api.claude = lazy('claude')
---@module 'config.api.smelly_sunflower'
api.smelly_sunflower = lazy('smelly_sunflower')
---@module 'config.api.diagnostics'
api.diagnostics = lazy('diagnostics')
---@module 'config.api.file'
api.file = lazy('file')
---@module 'config.api.git'
api.git = lazy('git')
---@module 'config.api.help'
api.help = lazy('help')
---@module 'config.api.job'
api.job = lazy('job')
---@module 'config.api.keymap'
api.keymap = lazy('keymap')
---@module 'config.api.lsp'
api.lsp = lazy('lsp')
---@module 'config.api.sticky'
api.sticky = lazy('sticky')
---@module 'config.api.tab'
api.tab = lazy('tab')
---@module 'config.api.telescope'
api.telescope = lazy('telescope')
---@module 'config.api.terminal'
api.terminal = lazy('terminal')
---@module 'config.api.text'
api.text = lazy('text')
---@module 'config.api.ui'
api.ui = lazy('ui')
---@module 'config.api.window'
api.window = lazy('window')
---@module 'config.api.dotnet'
api.dotnet = lazy('dotnet')
---@module 'config.api.perf'
api.perf = lazy('perf')
---@module 'config.api.statuscolumn'
api.status_column = lazy('statuscolumn')
---@module 'config.api.misc'
api.misc = lazy('misc')
---@module 'config.api.conflict'
api.conflict = lazy('conflict')

return api
