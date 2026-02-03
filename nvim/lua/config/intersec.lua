local uv = vim.uv
local timer = uv.new_timer()
local s = 1000
timer:start(0, 3 * s, vim.schedule_wrap(function()
  local min = os.date("%M")
  if os.date("%H") == "9" and (min == "58" or min == "58") then
    vim.notify_once("Daily", "info", {
      timeout = 240 * s,
    })
  end
end))

timer:start(0, 3 * s, vim.schedule_wrap(function()
  if os.date("%H") == "10" and os.date("%M") == "30" then
    vim.notify_once("Nightly", "info", {
      timeout = 240 * s,
    })
  end
end))

timer:start(0, 3 * s, vim.schedule_wrap(function()
  if os.date("%H") == "14" and os.date("%M") == "58" and
    os.date("%A") == "mardi" then
    vim.notify_once("Point technique", "info", {
      timeout = 240 * s,
    })
  end
end))

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.g.vim_start_time = vim.fn.localtime()
  end,
})

-- Function to get uptime
local function get_vim_uptime()
  if vim.g.vim_start_time then
    return vim.fn.localtime() - vim.g.vim_start_time
  end
  return 0
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    local started = get_vim_uptime() > 2
    local pwd = vim.fn.getcwd()
    local outside_pwd = require('config/utils').is_file_outside_pwd()
    local normal = vim.api.nvim_buf_get_option(0, 'buftype') == ""

    if outside_pwd and pwd:find('mmsx') and normal and started then
      vim.cmd('hi normal guibg=#151623')
    else
      vim.cmd('hi normal guibg=#24273b')
    end
  end,
})
