require("config/lazy")

vim.cmd("source ~/.config/nvim/lua/config/mappings.vim")
vim.cmd("source ~/.config/nvim/lua/config/preferences.vim")

require("config/clipboard")
require("config/custom-commands")

if os.getenv("IS_INTERSEC") == "true" then
  vim.cmd("source ~/.config/nvim/lua/config/intersec.vim")
end


