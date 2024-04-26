-- ~/.config/nvim/lua/config/

require("config/packages")

vim.cmd("source ~/.config/nvim/lua/config/preferences.vim")
vim.cmd("source ~/.config/nvim/lua/config/mappings.vim")

require("config/clipboard")
require("config/packages-preferences")

vim.cmd("source ~/.config/nvim/lua/config/intersec.vim")
