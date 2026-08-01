local api = require("config/api")

vim.api.nvim_create_user_command("CopyPath", function()
  vim.cmd("let @+ = expand('%')")
end, { nargs = 0 })

vim.api.nvim_create_user_command("CopyPathWithLine", function()
  vim.cmd("let @+ = expand('%') .. ':' .. line('.')")
end, { nargs = 0 })

vim.api.nvim_create_user_command("OpenSession", function(args)
  if #args.fargs == 1 then
    vim.cmd("source " .. args.fargs[1])
  else
    if vim.fn.filereadable("./Session.vim") then
      vim.cmd("source ./Session.vim")
    else
      vim.cmd("source ~/Session.vim")
    end
  end
end, { nargs = '?' })

vim.api.nvim_create_user_command("Restart", function()
  local restart_exit_code = 22
  vim.cmd("cquit " .. restart_exit_code)
end, { nargs = 0 })


local resources = {
  'anvil', 'solid', 'bank-listener', 'block-listener', 'exchange-listener',
  'block-monitor', 'eva', 'postgres', 'redis', 'mock'
}

local complete_rebuild = function(ArgLead)
  return vim.tbl_filter(function(resource)
    return vim.startswith(resource, ArgLead)
  end, resources)
end

vim.api.nvim_create_user_command("Rebuild", function(args)
  local service = args.fargs[1]

  local fidget = require("fidget")
  local spinner = fidget.progress.handle.create({
    title = "Building " .. service,
  })

  local on_exit = function(obj)
    if obj.code == 0 then
      vim.notify(service .. " has been rebuild")
    else
      vim.notify('Failed to rebuild ' .. service, vim.log.levels.ERROR)
    end
    spinner:finish()
  end

  vim.system({ vim.o.shell, "-c", "rebuild " .. service }, {}, on_exit)
end, { nargs = 1, complete = complete_rebuild })

-- Used by lazygit
vim.api.nvim_create_user_command("ToggleFterm", function(args)
  local term_name = args.fargs[1]
  api.sticky.toggle_existing(term_name)
end, { nargs = 1 })

-- Used by lazygit
vim.api.nvim_create_user_command("FromFTToTab", function(args)
  local name = args.fargs[1]

  if name then
    local line = "1"

    if #args.fargs == 2 then
      line = args.fargs[2]
    end

    -- Close the popup with lazygit so I can see the opened file
    if vim.bo.filetype == "ft_lazygit" then
      vim.cmd("q")
    end

    -- Once the popup is closed "e" will open the file outside the popup
    vim.cmd("e +" .. line .. " " .. name)
  end
end, { nargs = '+' })

vim.api.nvim_create_user_command("KillStickyTerminal", function(args)
  api.sticky.kill(args.fargs[1])
end, { nargs = 1 })

vim.api.nvim_create_user_command("FormatJson", function(_)
  vim.cmd(':%!jq .')
end, { nargs = 0 })
