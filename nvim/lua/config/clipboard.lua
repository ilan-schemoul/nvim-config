if os.getenv('WSL_DISTRO_NAME') ~= nil then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
else
  local function copy(lines, _)
    require('osc52').copy(table.concat(lines, '\n'))
  end

  local function paste()
    return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
  end

  vim.g.clipboard = {
    name = 'osc52',
    copy = {['+'] = copy, ['*'] = copy},
    paste = {['+'] = paste, ['*'] = paste},
  }
end
