require("config/lazy")

require("config/native_plugins")
require("config/user_commands")
require("config/auto_commands")
require("config/cron")

vim.cmd("source ~/.config/nvim/lua/config/preferences.vim")

require("config/mappings")
require("config/clipboard")
