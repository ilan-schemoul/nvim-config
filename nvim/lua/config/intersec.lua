local uv = vim.uv
local timer = uv.new_timer()
local s = 1000
timer:start(0, 3 * s, vim.schedule_wrap(function()
  if os.date("%H") == "10" and os.date("%M") == "58" then
    vim.notify_once("Daily", "info", {
      timeout = 240 * s,
    })
  end
end))
