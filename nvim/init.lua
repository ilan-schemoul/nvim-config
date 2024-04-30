-- ~/.config/nvim/lua/config/

require("config/lazy")

vim.cmd("source ~/.config/nvim/lua/config/preferences.vim")
vim.cmd("source ~/.config/nvim/lua/config/mappings.vim")

require("config/clipboard")
require("config/packages-preferences")

if os.getenv("IS_INTERSEC") == "true" then
    vim.cmd("source ~/.config/nvim/lua/config/intersec.vim")
end
