local function set_cmdline(keys, cmd)
  vim.keymap.set("c", keys, cmd, { unique = true })
end

set_cmdline('<C-A>', '<Home>')
set_cmdline('<C-h>', '<Left>')
set_cmdline('<C-l>', '<Right>')
set_cmdline('<C-BS>', '<C-W>')
set_cmdline('<A-Left>', '<S-Left>')
set_cmdline('<A-Right>', '<S-Right>')
set_cmdline('<A-b>', '<S-Left>')
set_cmdline('<A-f>', '<S-Right>')

