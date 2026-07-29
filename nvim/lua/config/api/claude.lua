local M = {}

M.send = function(opts)
  local terminal = require("claudecode/terminal")
  local claude = require("claudecode")

  if claude.is_claude_connected() then
    terminal.send_to_terminal("/model " .. opts.model)
    terminal.send_to_terminal(opts.prompt)
  else
    terminal.open({}, " --model " .. opts.model)

    local timer = vim.uv.new_timer()
    local wait_first_run_ms = 400
    timer:start(wait_first_run_ms, 50, function ()
      vim.schedule(function()
        if claude.is_claude_connected() then
          terminal.send_to_terminal(opts.prompt)
          timer:stop()
        end
      end)
    end)
  end
end

return M
