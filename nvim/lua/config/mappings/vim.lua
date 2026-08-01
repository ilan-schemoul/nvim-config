local mappings_utils = require('config/mappings/utils')
local api = require('config/api')

local set = mappings_utils.set

local nvim_config_path = vim.uv.fs_realpath(vim.fn.expand("~/.config/nvim"))
local nvim_root_path = vim.fn.expand(nvim_config_path .. "/..")
nvim_config_path = nvim_config_path or "~/.config/nvim"

set("vpl", "<cmd>Telescope find_files search_dirs=~/.local/share/nvim/lazy<cr>")
set("vpg", "<cmd>Telescope live_grep search_dirs=~/.local/share/nvim/lazy<cr>")
set("vw", "<cmd>tcd " .. nvim_root_path .. "<cr>")
set("vm", "<cmd>Telescope find_files search_dirs=" .. nvim_config_path .. "/lua/config/mappings<cr>")
set("vg", "<cmd>Telescope live_grep search_dirs=" .. nvim_root_path .. "<cr>")
set("va", "<cmd>next " .. nvim_config_path .. "/lua/config/api.lua<cr>")
set("vl", "<cmd>Telescope find_files search_dirs=" .. nvim_root_path .. "<cr>")
set("vG", function()
  api.toggle_lazygit(false, nvim_root_path)
end)
set("vt", "<cmd>e ~/nvim-main/todo.norg<cr>")
set("vv", "<cmd>mapclear | source ~/.config/nvim/init.lua<cr>")
