require("config/lazy")

require("config/custom-commands")

vim.cmd("source ~/.config/nvim/lua/config/preferences.vim")

require("config/mappings")
require("config/clipboard")

if os.getenv("IS_INTERSEC") == "true" then
  vim.cmd("source ~/.config/nvim/lua/config/intersec.vim")
end


