local utils = require("config/utils")
local mappings_utils = require('config/mappings/utils')

local setv = mappings_utils.setv
local set = mappings_utils.set

vim.keymap.set("n", "gco", function()
  utils.comment_above_or_below(0)
end, { desc = "Add comment below" })

vim.keymap.set("n", "gcO", function()
  utils.comment_above_or_below(-1)
end, { desc = "Add comment above" })

set("rp", ":%s/", "Replace in file")
setv("rp", ":s/", "Replace in selection")

vim.keymap.set('n', "gca", function()
  local l_cms, r_cms = string.match(vim.bo.commentstring, '(.*)%%s(.*)')
  local comment = l_cms .. ' ' .. r_cms
  local line = vim.api.nvim_get_current_line() .. " " .. comment
  vim.api.nvim_set_current_line(line)
  vim.api.nvim_feedkeys('A ', 'ni', true)
end, { desc = "Append comment to line" })

vim.keymap.set("n", "<leader>cc", "gcc", { remap = true, desc = "Toggle comment on line" })
vim.keymap.set("n", "<leader>co", "gco", { remap = true, desc = "Add comment below" })
vim.keymap.set("n", "<leader>cO", "gcO", { remap = true, desc = "Add comment above" })
vim.keymap.set("n", "<leader>ca", "gca", { remap = true, desc = "Append comment to line" })

vim.keymap.set("t", "<A-esc>", "<c-\\><c-n>", { remap = false, desc = "Exit terminal mode" })
vim.keymap.set("t", "<A-;>", "<c-\\><c-n>", { remap = false, desc = "Exit terminal mode" })

vim.keymap.set("t", "<C-6>", "<c-\\><c-n><c-6>", { desc = "Alternate buffer" })
vim.keymap.set("t", "<C-->", "<c-\\><c-n><c-6>", { desc = "Alternate buffer" })
