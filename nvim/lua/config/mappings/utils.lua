M = {}

M.set = function(keys, cmd)
  vim.keymap.set("n", "<leader>" .. keys, cmd, { unique = true })
end

M.setv = function(keys, cmd)
  vim.keymap.set("v", "<leader>" .. keys, cmd, { unique = true })
end

M.fr = { "à", "&", "é", "\"", "'", "(", "-", "è", "_", "ç" }

return M
