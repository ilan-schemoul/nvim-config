M = {}

M.set = function(keys, cmd, desc)
  vim.keymap.set("n", "<leader>" .. keys, cmd, { unique = true, desc = desc })
end

M.setv = function(keys, cmd, desc)
  vim.keymap.set("v", "<leader>" .. keys, cmd, { unique = true, desc = desc })
end

M.fr = { "à", "&", "é", "\"", "'", "(", "-", "è", "_", "ç" }

return M
