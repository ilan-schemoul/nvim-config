-- ~/.config/nvim/lua/config/

vim.loader.enable()

require("config/packages")

vim.cmd("source ~/.config/nvim/lua/config/basic.vim")
vim.cmd("source ~/.config/nvim/lua/config/preferences.vim")
vim.cmd("source ~/.config/nvim/lua/config/mappings.vim")

require("config/clipboard")
require("config/packages-preferences")
require("config/debuggers-configuration")
