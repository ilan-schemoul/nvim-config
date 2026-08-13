local M = {}

local function telescope_args()
  local oil_dir = require("oil").get_current_dir()
  local root = oil_dir or vim.fn.getcwd()
  local title = vim.fn.fnamemodify(root, ":~")

  return {
    cwd = root,
    prompt_title = title,
  }
end

-- Live grep from the Oil directory when called from an Oil buffer, cwd otherwise
function M.live_grep()
  local opts = telescope_args()

  require("telescope.builtin").live_grep({
    cwd = opts.cwd,
    prompt_title = "Grep in " .. opts.prompt_title,
  })
end

function M.smart_open()
  local opts = telescope_args()

  require('telescope').extensions.smart_open.smart_open({
    cwd = opts.cwd,
    cwd_only = true,
    prompt_title = "Find a file in " .. opts.prompt_title,
  })
end

return M
