local sticky = require('config/api/sticky')
--TODO: call claude code start

local M = {
  fterm_mode = nil,
}

function M.send_raw(txt)
  vim.cmd({ cmd = 'ClaudeCodeSendText', args = { txt } })
end

local do_when_ready = function(fn)
  local claude = require('claudecode')
  local timer = vim.uv.new_timer()
  local wait_first_run_ms = 400

  if timer then
    timer:start(wait_first_run_ms, 50, function ()
      vim.schedule(function()
        if claude.is_claude_connected() then
          fn()
          timer:stop()
        end
      end)
    end)
  end
end

function M.send(prompt)
  local claude = require('claudecode')

  if claude.is_claude_connected() then
    claude._ensure_terminal_visible_if_connected()
    M.send_raw(prompt)
  else
    vim.cmd('ClaudeCode')

    do_when_ready(function()
      M.send_raw(prompt)
    end)
  end
end

local provider = {
  setup = function(cfg)
    require("claudecode/terminal/native").setup(cfg)
  end,

  open = function(cmd_string, env_table, effective_config, focus)
    if M.fterm_mode then
      vim.notify('Not implemented')
    else
      require("claudecode/terminal/native").open(cmd_string, env_table, effective_config, focus)
    end
  end,

  close = function()
    if M.fterm_mode then
      vim.notify('Not implemented')
    else
      require("claudecode/terminal/native").close()
    end
  end,

  simple_toggle = function(cmd_string, env_table, effective_config)
    if M.fterm_mode then
      sticky.toggle_or_create("claude", cmd_string, {
        env = env_table
      })
    else
      require("claudecode/terminal/native").simple_toggle(cmd_string, env_table, effective_config)
    end
  end,

  focus_toggle = function(cmd_string, env_table, effective_config)
    if M.fterm_mode then
      sticky.toggle_or_create("claude", cmd_string, {
        env = env_table
      })
    else
      require("claudecode/terminal/native").focus_toggle(cmd_string, env_table, effective_config)
    end
  end,

  get_active_bufnr = function()
    if M.fterm_mode then
      vim.notify('Not implemented')
    else
      return require("claudecode/terminal/native").get_active_bufnr()
    end
  end,

  is_available = function()
    return true
  end,
}

M.terminal_provider = provider

function M.open_fterm()
  M.fterm_mode = true
  vim.cmd('ClaudeCode')
  M.fterm_mode = nil
end


function M.send_bookmarks(all)
  local haunt_sk = require("haunt.sidekick")

  local locations = haunt_sk.get_locations({ current_buffer = not all })
  M.send(locations)
end

function M.send_all_bookmarks()
  M.send_bookmarks(true)
end

return M
