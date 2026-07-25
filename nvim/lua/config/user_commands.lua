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

vim.api.nvim_create_user_command("H", function(args)
  local arg = args.fargs[1]
  vim.cmd("helpg " .. arg)
  require("telescope.builtin").quickfix()
end, { nargs = '+' })

-- Used by lazygit
vim.api.nvim_create_user_command("FromFTToTab", function(args)
  local name = args.fargs[1]

  if name then
    local line = "1"

    if #args.fargs == 2 then
      line = args.fargs[2]
    end

    -- Close the popup with lazygit so I can see the opened file
    if vim.bo.filetype == "lazygit" then
      vim.cmd("q")
    end

    -- Once the popup is closed "e" will open the file outside the popup
    vim.cmd("e +" .. line .. " " .. name)
  end
end, { nargs = '+' })

vim.api.nvim_create_user_command("KillStickyTerminal", function(args)
  api.kill_sticky_terminal(args.fargs[1])
end, { nargs = 1 })
