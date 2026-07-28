local utils = require("config/utils")
local mappings_utils = require('config/mappings/utils')

local setv = mappings_utils.setv
local set = mappings_utils.set

vim.keymap.set("n", "gco", function()
  utils.comment_above_or_below(0)
end)

vim.keymap.set("n", "gcO", function()
  utils.comment_above_or_below(-1)
end)

set("rp", ":%s/")
setv("rp", ":s/")

vim.keymap.set('n', "gca", function()
  local l_cms, r_cms = string.match(vim.bo.commentstring, '(.*)%%s(.*)')
  local comment = l_cms .. ' ' .. r_cms
  local line = vim.api.nvim_get_current_line() .. " " .. comment
  vim.api.nvim_set_current_line(line)
  vim.api.nvim_feedkeys('A ', 'ni', true)
end)

vim.keymap.set("n", "<leader>cc", "gcc", { remap = true })
vim.keymap.set("n", "<leader>co", "gco", { remap = true })
vim.keymap.set("n", "<leader>cO", "gcO", { remap = true })
vim.keymap.set("n", "<leader>ca", "gca", { remap = true })

vim.keymap.set("t", "<A-esc>", "<c-\\><c-n>", { remap = false })
vim.keymap.set("t", "<A-;>", "<c-\\><c-n>", { remap = false })

vim.keymap.set("t", "<C-6>", "<c-\\><c-n><c-6>")
vim.keymap.set("t", "<C-->", "<c-\\><c-n><c-6>")
