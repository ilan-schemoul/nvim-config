local function set_cmdline(keys, cmd, desc)
  vim.keymap.set("c", keys, cmd, { unique = true, desc = desc })
end

set_cmdline('<C-A>', '<Home>', "Go to start of command line")
set_cmdline('<C-h>', '<Left>', "Move left")
set_cmdline('<C-l>', '<Right>', "Move right")
set_cmdline('<C-BS>', '<C-W>', "Delete word before cursor")
set_cmdline('<A-Left>', '<S-Left>', "Move back one word")
set_cmdline('<A-Right>', '<S-Right>', "Move forward one word")
set_cmdline('<A-b>', '<S-Left>', "Move back one word")
set_cmdline('<A-f>', '<S-Right>', "Move forward one word")

