local timer = vim.uv.new_timer()
-- Sync roughly with crontab. Crontab executes roughly first second of each
-- minute. So first run waits to be synced with first run.
local wait_first_run_ms = (60 - tonumber(os.date("%S")) + 2) * 1000

if timer then
  timer:start(wait_first_run_ms, 60 * 1000, function()
    vim.schedule(function()
      local _, line = pcall(vim.fn.readfile, "/tmp/thermal")

      if line[1] == "Heavy" then
        vim.notify("Overheating" , vim.log.levels.WARN)
      end
    end)
  end)
end
