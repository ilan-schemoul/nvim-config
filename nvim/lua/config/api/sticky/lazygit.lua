local fterm = require("config/api/sticky/fterm")
local file = require("config/api/file")

local M = {}

local last_lazygit_root = nil

local refresh_buffer = function()
  if vim.api.nvim_buf_get_name(0) ~= "" then
    vim.cmd("Gitsigns refresh")
    vim.cmd("checktime")
  end
end

function M.get_lazygit_cwd(root)
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

function M.refresh()
  vim.schedule(function()
    pcall(refresh_buffer)
  end)

  vim.defer_fn(function()
    pcall(refresh_buffer)
  end, 500)
end

-- Fullscreen lazygit rooted at the git root, refreshing the buffers it touched on exit
function M.toggle(force_new, cwd)
  local on_exit = M.refresh

  local root = cwd or M.get_lazygit_cwd()

  if last_lazygit_root ~= root then
    last_lazygit_root = root
    force_new = true
  end

  local opts = {
    force_new = force_new,
    on_exit = on_exit,
    on_q = on_exit,
    border = 'rounded',
    cwd = root,
    dimensions = {
      height = 1,
      width = 1,
    }
  }

  fterm.toggle_or_create("lazygit", { "lazygit" }, opts)
end

return M
