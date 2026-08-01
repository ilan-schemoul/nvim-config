local utils = require('config/utils')
local mappings_utils = require('config/mappings/utils')
local set = mappings_utils.set

for _, key in ipairs({ ")", "]" }) do
  set(key .. "d", utils.diagnostic_goto(true), "Next diagnostic")
  set(key .. "e", utils.diagnostic_goto(true, "ERROR"), "Next error")
  set(key .. "w", utils.diagnostic_goto(true, "WARN"), "Next warning")
end

for _, key in ipairs({ "(", "[" }) do
  set(key .. "d", utils.diagnostic_goto(false), "Previous diagnostic")
  set(key .. "e", utils.diagnostic_goto(false, "ERROR"), "Previous error")
  set(key .. "w", utils.diagnostic_goto(false, "WARN"), "Previous warning")
end

set("lD", function() vim.diagnostic.open_float({ source = true }) end, "Show diagnostic in float")

set("lh", vim.lsp.buf.hover, "Show hover doc")
set("li", "<cmd>Telescope lsp_references<cr>", "List LSP references")
set("lI", vim.lsp.buf.implementation, "Go to implementation")
set("ld", "<cmd>Telescope lsp_definitions<cr>", "Go to definition")
set("lb", function() require("telescope.builtin").diagnostics({ sort_by="severity" }) end, "List diagnostics (by severity)")
set("ls", "<cmd>Telescope lsp_workspace_symbols<cr>", "List workspace symbols")
set("lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Search workspace symbols")
set("ln", function()
  vim.lsp.buf.rename()
  vim.cmd('silent! wa')
end, "Rename symbol")
set("la", vim.lsp.buf.code_action, "Code action")
