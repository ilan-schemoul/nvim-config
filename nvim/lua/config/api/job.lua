local M = {}

local function execute_command(cmds, opts, index)
  if index > #cmds then
    return
  end

  M._async_spinner.message = table.concat(cmds[index], " ")

  vim.system(cmds[index], opts, function(obj)
    if obj.code ~= 0 then
      local message = table.concat(cmds[index], " ") .. " " .. (obj.stderr or "")
      M._async_spinner:finish()
      vim.notify(message, vim.log.levels.ERROR)
      return
    end

    if index == #cmds then
      M._async_spinner:finish()
      if obj.stdout and obj.stdout ~= "" then
        vim.notify(obj.stdout, vim.log.levels.INFO)
      end
      return
    end

    execute_command(cmds, opts, index + 1)
  end)
end

-- Run the given commands one after the other, notify the user on error
function M.run(cmds, opts, title)
  local fidget = require("fidget")
  M._async_spinner = fidget.progress.handle.create({
    title = title,
  })

  execute_command(cmds, opts, 1)
end

function M.run_shell(cmd, opts, title)
  M.run({ { vim.o.shell, vim.o.shellcmdflag, cmd } }, opts, title)
end

return M
