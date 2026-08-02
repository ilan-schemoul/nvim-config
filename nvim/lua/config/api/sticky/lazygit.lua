local fterm = require("config/api/sticky/fterm")
local file = require("config/api/file")

local M = {}

local last_lazygit_root = nil

local refresh_buffer = function()
  if vim.api.nvim_buf_get_name(0) ~= "" then
    vim.cmd("Gitsigns refresh")
    vim.cmd("windo e")
  end
end

local get_lazygit_cwd = function(root)
  root = root or file.cwd()

  if not root then
    root = last_lazygit_root
  else
    root = vim.uv.fs_realpath(root) or root

    if not root then
      return last_lazygit_root
    else
      return vim.fs.root(root, ".git") or last_lazygit_root
    end
  end
end

-- Fullscreen lazygit rooted at the git root, refreshing the buffers it touched on exit
function M.toggle(force_new, cwd)
  local on_exit = function()
      vim.schedule(function()
        pcall(refresh_buffer)
      end)
  end

  local root = cwd or get_lazygit_cwd()

  if last_lazygit_root ~= root then
    last_lazygit_root = root
    force_new = true
  end

  local opts = {
    force_new = force_new,
    on_exit = on_exit,
    border = 'rounded',
    dimensions = {
      height = 1,
      width = 1,
    }
  }

  local cmd = { "lazygit" }

  if root then
    table.insert(cmd, "--path")
    table.insert(cmd, root)
  end

  fterm.toggle_or_create("lazygit", cmd, opts)
end

return M
