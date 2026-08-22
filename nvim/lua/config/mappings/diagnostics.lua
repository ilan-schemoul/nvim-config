local api = require('config/api')
local set = api.keymap.leader

for _, key in ipairs({ ")", "]" }) do
  vim.keymap.set("n", key .. "d", api.diagnostics.jump(true), { desc = "Next diagnostic" })
  vim.keymap.set("n", key .. "e", api.diagnostics.jump(true, "ERROR"), { desc = "Next error" })
  vim.keymap.set("n", key .. "w", api.diagnostics.jump(true, "WARN"), { desc = "Next warning" })
end

for _, key in ipairs({ "(", "[" }) do
  vim.keymap.set("n", key .. "d", api.diagnostics.jump(false), { desc = "Previous diagnostic" })
  vim.keymap.set("n", key .. "e", api.diagnostics.jump(false, "ERROR"), { desc = "Previous error" })
  vim.keymap.set("n", key .. "w", api.diagnostics.jump(false, "WARN"), { desc = "Previous warning" })
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
