local M = {}

local record = require("recorder")

M.stop_start_macro_event = function()
  local status = record.recordingStatus()
  -- We put the opposite with not because we are warned of the opposite event
  -- (we are called before the recorder plugin).
  if #status > 0 then
    vim.api.nvim_set_hl(0, 'Cursor', {})
  else
    vim.api.nvim_set_hl(0, 'Cursor', {
      bg = '#ED5919',
    })
  end
end

return M
