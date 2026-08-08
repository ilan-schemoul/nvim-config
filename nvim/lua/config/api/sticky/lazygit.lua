local fterm = require("config/api/sticky/fterm")
local file = require("config/api/file")

local M = {}

local refresh_buffer = function()
  if vim.api.nvim_buf_get_name(0) ~= "" then
    vim.cmd("Gitsigns refresh")
    vim.cmd("checktime")
    require("lint").try_lint()
  end
end

function M.get_lazygit_cwd()
  local root = file.cwd()
  root = vim.uv.fs_realpath(root) or root
  return root
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

  local opts = {
    force_new = true,
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
