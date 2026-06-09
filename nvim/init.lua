-- I added this so I can have binaries that override the ones outside nvim
vim.env.PATH = '/home/ilan/.bin/nvim-internal-path:' .. vim.env.PATH

require("config/lazy")

require("config/custom-commands")

vim.cmd("source ~/.config/nvim/lua/config/preferences.vim")

require("config/mappings")
require("config/clipboard")
