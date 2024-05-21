vim.api.nvim_create_autocmd({"InsertLeave"}, {
  callback = function(args)
    buf = vim.api.nvim_win_get_buf(0)

    if vim.bo[buf].readonly then
      vim.notify("Cannot save. Use :TeeSave.", "warn")
    end
  end,
})

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
