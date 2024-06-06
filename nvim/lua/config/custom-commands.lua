vim.api.nvim_create_autocmd({"InsertLeave"}, {
  callback = function(args)
    buf = vim.api.nvim_win_get_buf(0)

    if vim.bo[buf].readonly then
      vim.notify("Cannot save. Use :TeeSave.", "warn")
    end
  end,
})

local function send_to_term(cmd_text)
  if not cmd_text then
    return
  end

  local function get_first_terminal()
    local terminal_chans = {}
    for _, chan in pairs(vim.api.nvim_list_chans()) do
      if chan["mode"] == "terminal" and chan["pty"] ~= "" then
        table.insert(terminal_chans, chan)
      end
    end

    if #terminal_chans == 0 then
      return nil
    end

    terminal_chans = vim.tbl_filter(function(chan)
      return vim.fn.getbufinfo(chan["buffer"])[1].hidden == 0
    end, terminal_chans)

    table.sort(terminal_chans, function(left, right)
      return left["buffer"] < right["buffer"]
    end)

    return terminal_chans[1]["id"]
  end

  local send_to_terminal = function(terminal_chan, term_cmd_text)
    vim.api.nvim_chan_send(terminal_chan, term_cmd_text .. "\n")
  end

  local terminal = get_first_terminal()

  if not terminal then
    vim.cmd("term")
    terminal = get_first_terminal()
  end

  send_to_terminal(terminal, cmd_text)
end

vim.api.nvim_create_user_command("SendToTerm", function(args)
  if #args.args ~= 0 then
    send_to_term(args.args)
  else
    vim.ui.input({
      prompt = "SendToTerm"
    }, send_to_term)
  end
end, { nargs = "?" })

vim.api.nvim_create_user_command("AddPlugin", function(args)
  local full_name = args.fargs[1]

  local _, _, _, file_name = string.find(full_name, "(.*)/(.*)")
  vim.cmd("edit ~/.config/nvim/lua/plugins/" .. file_name .. ".lua")


  local lines = {
    "return {",
    "  \"" .. full_name .. "\",",
    "  opts = {},",
    "}",
  }

  local id = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_set_lines(id, 0, 0, false, lines)
  vim.cmd("write")
  vim.api.nvim_win_set_cursor(0, {3,10})
  vim.cmd("Lazy")
end, { nargs = 1 })
