local mappings_utils = require('config/mappings/utils')

local set = mappings_utils.set

set("vpl", "<cmd>Telescope find_files search_dirs=~/.local/share/nvim/lazy<cr>")
set("vpg", "<cmd>Telescope live_grep search_dirs=~/.local/share/nvim/lazy<cr>")
set("vw", "<cmd>tcd ~/.config/nvim<cr>")
set("vm", "<cmd>Telescope find_files search_dirs=~/.config/nvim/lua/config/mappings<cr>")
set("vg", "<cmd>Telescope live_grep search_dirs=~/.config/nvim<cr>")
set("va", "<cmd>next ~/.config/nvim/lua/config/api.lua<cr>")
set("vl", "<cmd>Telescope find_files search_dirs=~/.config/nvim<cr>")
set("vt", "<cmd>e ~/nvim-main/todo.norg<cr>")
set("vv", "<cmd>mapclear | source ~/.config/nvim/init.lua<cr>")
