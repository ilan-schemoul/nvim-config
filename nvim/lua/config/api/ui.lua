local api = require('config/api')
local M = {}

function M.set_float_hl_by_filetype(ft_to_hl)
  local ns_id = 1000

  vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*',
    callback = function (_)
      local hl = ft_to_hl[vim.bo.ft]

      if not hl then
        return
      end

      local window = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_hl_ns(window, ns_id)

      vim.api.nvim_set_hl(ns_id, 'FloatBorder', {
        fg = hl.border
      })

      vim.api.nvim_set_hl(ns_id, 'Normal', {
        bg = hl.bg
      })

      ns_id = ns_id + 1
    end,
  })
end

-- Called right before the recorder plugin toggles, hence the inverted check
function M.toggle_recording_cursor_hl()
  local record = require("recorder")
  local status = record.recordingStatus()
  -- We put the opposite with not because we are warned of the opposite event
  -- (we are called before the recorder plugin).
  if #status > 0 then
    vim.api.nvim_set_hl(0, 'Cursor', {
      bg = '#b8b8b8'
    })
  else
    vim.api.nvim_set_hl(0, 'Cursor', {
      bg = '#ED5919',
    })
  end
end

return M
