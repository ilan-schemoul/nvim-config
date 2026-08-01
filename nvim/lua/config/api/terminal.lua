local buffer = require("config/api/buffer")

local M = {}

M.start_insert_if_bottom = function()
  local total_number_of_lines = vim.fn.line("$")
  local current_line = vim.fn.line(".")
  local nb_lines_to_bottom_screen = total_number_of_lines - current_line
  local height = vim.api.nvim_win_get_height(0) + 1

  -- total_number_of_lines < height = new terminal => insert mode when focus
  -- nb_lines_to_bottom_screen < height => cursor close to the bottom => insert mode when focus
  -- else nb_lines_to_bottom_screen >= height => I put my cursor somewhere specific on purpose
  -- => I do not want to lose that line by going insert mode (which scroll to the bottom)
  if total_number_of_lines < height or nb_lines_to_bottom_screen < height then
    vim.cmd("startinsert")
  end
end

-- Solution given by Justin himself !
local function terminal_is_available(buf)
    local is_terminal = vim.bo[buf].buftype == "terminal"
    if not is_terminal then
      return false
    end

    local channel = vim.bo[buf].channel
    local child_process = vim.api.nvim_get_proc_children(vim.fn.jobpid(channel))
    local child_process_nb = vim.tbl_count(child_process)

    return child_process_nb == 0
end

M.open_unused_or_create = function()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    local opened = vim.fn.bufwinnr(buf) ~= -1

    if not opened and buffer.is_listed(buf) and terminal_is_available(buf) then
      vim.cmd(":buffer " .. buf)
      return
    end
  end

  vim.cmd(":term")
end

-- Needed by the `<cmd>vsplit | lua ...<cr>` mappings, which cannot see locals
_G.OpenUnusedTermOrCreate = M.open_unused_or_create

return M
