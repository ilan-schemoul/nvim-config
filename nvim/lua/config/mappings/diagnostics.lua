local utils = require('config/utils')
local mappings_utils = require('config/mappings/utils')
local set = mappings_utils.set

for _, key in ipairs({ ")", "]" }) do
  set(key .. "d", utils.diagnostic_goto(true))
  set(key .. "e", utils.diagnostic_goto(true, "ERROR"))
  set(key .. "w", utils.diagnostic_goto(true, "WARN"))
end

for _, key in ipairs({ "(", "[" }) do
  set(key .. "d", utils.diagnostic_goto(false))
  set(key .. "e", utils.diagnostic_goto(false, "ERROR"))
  set(key .. "w", utils.diagnostic_goto(false, "WARN"))
end

set("lD", function() vim.diagnostic.open_float({ source = true }) end)

set("lh", vim.lsp.buf.hover)
set("li", "<cmd>Telescope lsp_references<cr>")
set("lI", vim.lsp.buf.implementation)
set("ld", "<cmd>Telescope lsp_definitions<cr>")
set("lb", function() require("telescope.builtin").diagnostics({ sort_by="severity" }) end)
set("ls", "<cmd>Telescope lsp_workspace_symbols<cr>")
set("lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
set("ln", function()
  vim.lsp.buf.rename()
  vim.cmd('silent! wa')
end)
set("la", vim.lsp.buf.code_action)
