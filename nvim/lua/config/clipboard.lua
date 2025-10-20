if os.getenv("SSH_TTY") ~= nil then
  local function paste()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end

  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    -- For security reasons pasting is usually not supported by terminals for OSC52
    -- So we don't use clipboard.osc52 for pasting. Otherwise nvim hangs when pasting.
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
end
