local api = require('config/api')

local set = api.keymap.leader

local nvim_config_path = vim.uv.fs_realpath(vim.fn.expand("~/.config/nvim"))
local nvim_root_path = vim.fn.fnamemodify(nvim_config_path, ":h")
vim.print(nvim_root_path)
nvim_config_path = nvim_config_path or "~/.config/nvim"

set("vpl", "<cmd>Telescope find_files search_dirs=~/.local/share/nvim/lazy<cr>", "Find files in installed plugins")
set("vpg", "<cmd>Telescope live_grep search_dirs=~/.local/share/nvim/lazy<cr>", "Grep in installed plugins")
set("vw", "<cmd>tcd " .. nvim_root_path .. "<cr>", "Cd to nvim config root")
set("vm", "<cmd>Telescope find_files search_dirs=" .. nvim_config_path .. "/lua/config/mappings<cr>", "Find files in mappings config")
set("vg", "<cmd>Telescope live_grep search_dirs=" .. nvim_root_path .. "<cr>", "Grep in nvim config")
set("va", "<cmd>Telescope find_files search_dirs=" .. nvim_config_path .. "/lua/config/api<cr>", "Find files in api config")
set("vl", "<cmd>Telescope find_files search_dirs=" .. nvim_root_path .. "<cr>", "Find files in nvim config")
set("vG", function()
  api.sticky.lazygit.toggle(false, nvim_root_path)
end, "Toggle lazygit in nvim config")
set("vt", "<cmd>e ~/nvim-main/todo.norg<cr>", "Open nvim config todo")
set("vv", "<cmd>mapclear | source ~/.config/nvim/init.lua<cr>", "Reload nvim config")
