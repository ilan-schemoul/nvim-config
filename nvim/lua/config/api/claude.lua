local api = require('config/api')
--TODO: call claude code start

local M = {
  fterm_mode = nil,
  init_called = false,
}

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

local provider = {
  setup = function(cfg)
    require("claudecode/terminal/native").setup(cfg)
  end,

  open = function(cmd_string, env_table, effective_config, focus)
    if M.fterm_mode then
      M.sticky_terminals["ft_claude"]:open()
    else
      require("claudecode/terminal/native").open(cmd_string, env_table, effective_config, focus)
    end
  end,

  close = function()
    if M.fterm_mode then
      M.sticky_terminals["ft_claude"]:close()
    else
      require("claudecode/terminal/native").close()
    end
  end,

  simple_toggle = function(cmd_string, env_table, effective_config)
    if M.fterm_mode then
      api.toggle_or_create_sticky_term("claude", cmd_string, {
        env = env_table
      })
    else
      require("claudecode/terminal/native").simple_toggle(cmd_string, env_table, effective_config)
    end
  end,

  focus_toggle = function(cmd_string, env_table, effective_config)
    if M.fterm_mode then
      api.toggle_or_create_sticky_term("claude", cmd_string, {
        env = env_table
      })
    else
      require("claudecode/terminal/native").focus_toggle(cmd_string, env_table, effective_config)
    end
  end,

  get_active_bufnr = function()
    if M.fterm_mode then
      local term = api.sticky_terminals["ft_claude"]
      return term and term.buf
    else
      return require("claudecode/terminal/native").get_active_bufnr()
    end
  end,

  is_available = function()
    return true
  end,
}

M.claude_terminal_provider = provider

M.open_fterm = function()
  M.fterm_mode = true
  vim.cmd('ClaudeCode')
  M.fterm_mode = nil
end


return M
