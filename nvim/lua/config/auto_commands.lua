local utils = require('config/utils')
-- Absolute number if not focus
vim.api.nvim_create_autocmd({ "WinEnter" }, {
  callback = function()
    -- Normal buffer (not terminal etc.)
    if vim.wo[0].number then
      vim.wo[0].relativenumber = true
    end
  end,
})

-- Absolute number if not focus
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  callback = function()
    -- Normal buffer (not terminal etc.)
    if vim.wo[0].number then
      vim.wo[0].relativenumber = false
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function(_)
    local buf = vim.api.nvim_win_get_buf(0)

    if vim.bo[buf].readonly then
      vim.notify("Cannot save this file. Try :SudaWrite", vim.log.levels.ERROR)
    end
  end,
})

-- Close buffer if the terminal is closed
vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*",
  callback = function()
    -- XXX: disable for all fterm and handle it myself
    if (vim.bo.buftype == "terminal" or vim.bo.filetype == "lua") and vim.v.shell_error == 0 then
      -- Let me see errors
      if vim.bo.ft == "ft_aspire" or vim.bo.ft == "ft_lazygit" then
        return
      end

      vim.cmd("bdelete! " .. vim.fn.expand("<abuf>"))
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.jpg", "*.png" },
  callback = function()
    vim.cmd("setfiletype img")
  end,
})

local create_term_name = function(process)
  local bin = vim.fn.exepath(process.name)

  return "term://" .. vim.fn.getcwd() .. "//" .. process.pid .. ":" .. bin
end

local original_term_name = {}

-- Can be a bit slow 50/100ms
vim.api.nvim_create_autocmd({ "TermLeave"  }, {
  callback = function()
    local channel = vim.bo[0].channel
    local child_process = vim.api.nvim_get_proc_children(vim.fn.jobpid(channel))
    if #child_process > 0 then
      local process = vim.api.nvim_get_proc(child_process[1])
      local new_name = create_term_name(process)

      original_term_name[vim.bo[0].channel] = vim.api.nvim_buf_get_name(0)
      vim.api.nvim_buf_set_name(0, new_name)
    elseif original_term_name[vim.bo[0].channel] then
      vim.api.nvim_buf_set_name(0, original_term_name[vim.bo[0].channel])
    end
  end,
})

