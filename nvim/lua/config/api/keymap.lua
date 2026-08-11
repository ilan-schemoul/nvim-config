local M = {}

function M.leader(keys, cmd, desc, remap)
  remap = remap or false
  vim.keymap.set("n", "<leader>" .. keys, cmd, {
    unique = true,
    desc = desc,
    remap = true
  })
end

function M.leader_visual(keys, cmd, desc)
  vim.keymap.set("v", "<leader>" .. keys, cmd, { unique = true, desc = desc })
end

-- Characters on the digit row of an azerty keyboard, in 0-9 order
M.azerty_digits = { "à", "&", "é", "\"", "'", "(", "-", "è", "_", "ç" }

return M
