local M = {}

local file = require('config/api/file')

-- Live grep from the Oil directory when called from an Oil buffer, cwd otherwise
function M.live_grep()
  local dir = file.cwd()
  local title = vim.fn.fnamemodify(dir, ":~")

  require("telescope.builtin").live_grep({
    cwd = dir,
    prompt_title = title,
  })
end

function M.smart_open()
  local dir = file.cwd()
  local title = vim.fn.fnamemodify(dir, ":~")

  require('telescope').extensions.smart_open.smart_open {
    cwd = dir,
    prompt_title = title,
    cwd_only = true,
  }
end

return M
