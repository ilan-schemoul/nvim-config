local M = {}

local function execute_command(cmds, opts, index)
  if index > #cmds then
    return
  end

  M._async_spinner.message = table.concat(cmds[index], " ")

  vim.system(cmds[index], opts, function(obj)
    if obj.code ~= 0 then
      local message = cmds[index] .. " " .. obj.stderr
      vim.notify(message, vim.log.levels.ERROR)
    end

    execute_command(cmds, opts, index + 1)

    if index == #cmds then
      M._async_spinner:finish()
      if obj.code == 0 then
        vim.notify(obj.stdout, vim.log.levels.INFO)
      end
    end
  end)
end

-- Run the given commands one after the other, notify the user on error
M.run = function(cmds, opts, title)
  local fidget = require("fidget")
  M._async_spinner = fidget.progress.handle.create({
    title = title,
  })

  execute_command(cmds, opts, 1)
end

M.run_shell = function(cmd, opts, title)
  M.run({ { vim.o.shell, vim.o.shellcmdflag, cmd } }, opts, title)
end

return M
