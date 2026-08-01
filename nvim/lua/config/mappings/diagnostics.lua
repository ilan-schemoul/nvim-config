local api = require('config/api')
local set = api.keymap.leader

for _, key in ipairs({ ")", "]" }) do
  set(key .. "d", api.diagnostics.jump(true), "Next diagnostic")
  set(key .. "e", api.diagnostics.jump(true, "ERROR"), "Next error")
  set(key .. "w", api.diagnostics.jump(true, "WARN"), "Next warning")
end

for _, key in ipairs({ "(", "[" }) do
  set(key .. "d", api.diagnostics.jump(false), "Previous diagnostic")
  set(key .. "e", api.diagnostics.jump(false, "ERROR"), "Previous error")
  set(key .. "w", api.diagnostics.jump(false, "WARN"), "Previous warning")
end

set("lD", function() vim.diagnostic.open_float({ source = true }) end, "Show diagnostic in float")

set("lh", vim.lsp.buf.hover, "Show hover doc")
set("li", "<cmd>Telescope lsp_references<cr>", "List LSP references")
set("lI", vim.lsp.buf.implementation, "Go to implementation")
set("ld", "<cmd>Telescope lsp_definitions<cr>", "Go to definition")
set("lb", function() require("telescope.builtin").diagnostics({ sort_by="severity" }) end, "List diagnostics (by severity)")
set("ls", "<cmd>Telescope lsp_workspace_symbols<cr>", "List workspace symbols")
set("lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Search workspace symbols")
set("ln", api.lsp.rename, "Rename symbol")
set("la", vim.lsp.buf.code_action, "Code action")
