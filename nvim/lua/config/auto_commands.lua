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
      if vim.bo.ft == "ft_aspire" or vim.bo.ft == "ft_lazygit" or vim.bo.ft == "ft_pgcli" then
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

local function update_term_name(dir)
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
end

-- Can be a bit slow 50/100ms
vim.api.nvim_create_autocmd({ "TermLeave"  }, {
  callback = function()
    pcall(update_term_name)
  end,
})

-- Lazygit is weird, if you exit it you shift right so you counter-balance it by
-- going left
vim.api.nvim_create_autocmd({
    "FileType",
  },
  {
    pattern = "ft_lazygit",
    callback = function()
      vim.keymap.set("t", "<A-;>", function()
        vim.cmd("stopinsert")
        vim.fn.feedkeys("gg")
        vim.fn.feedkeys("^") -- beginning of the sentence
      end, { buffer = true })
    end
  })

local update_vim_dir = function(dir)
  local buf = vim.api.nvim_buf_get_name(0)
  local new = 'term://' .. dir .. '//'
  local new_name = buf:gsub('^term://(.-)//', new, 1)
  vim.api.nvim_buf_set_name(0, new_name)
end

local handle_dir_change = function(dir, buf)
  if vim.fn.isdirectory(dir) == 0 then
    vim.notify('invalid dir: '..dir)
    return
  end
  if vim.api.nvim_get_current_buf() == buf then
    vim.cmd.lcd(dir)

    update_vim_dir(dir)
  end
end

-- Straight from doc
vim.api.nvim_create_autocmd({ 'TermRequest' }, {
  desc = 'Handles OSC 7 dir change requests',
  callback = function(ev)
    local dir, n = string.gsub(ev.data.sequence, '\027]7;file://[^/]*', '')
    if n > 0 then
      handle_dir_change(dir, ev.buf)
    end
  end
})
