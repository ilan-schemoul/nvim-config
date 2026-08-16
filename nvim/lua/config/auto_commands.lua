local api = require('config/api')
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
    if vim.bo.ft == "ft_aspire" or vim.bo.ft == "ft_pgcli" or vim.bo.ft == "TelescopePrompt" then
      return
    end

    if vim.bo.ft == "ft_lazygit" and vim.v.shell_error ~= 0 then
      return
    end

    vim.cmd("bdelete! " .. vim.fn.expand("<abuf>"))
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.jpg", "*.png" },
  callback = function()
    vim.cmd("setfiletype img")
  end,
})

local function refresh_stc_width(args)
  -- GitSignsUpdate carries the buffer in data, DiagnosticChanged in buf.
  local buf = args.data and args.data.buffer or args.buf

  if not buf or not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "" then
    return
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    if vim.wo[win].statuscolumn ~= "" then
      -- Force refresh
      vim.wo[win].numberwidth = vim.wo[win].numberwidth
    end
  end
end

-- Refresh status column.
-- Not enabled because I am not sure if I want this (it moves the column)
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "GitSignsUpdate",
  callback = refresh_stc_width,
})
vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
  callback = refresh_stc_width,
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
      end, { buffer = true, desc = "Exit terminal mode and go to start" })
    end
  })

-- Saving like 10ms
vim.api.nvim_create_autocmd({ "User" },
  {
    pattern = "NormalBufferEnter",
    callback = function()
      vim.schedule(function()
        vim.cmd("set spelllang=en_us,programming,fr")
        vim.opt.spell = true
      end)
    end
  })

vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    local cache = vim.fn.stdpath("cache")
    local project_bookmarks = cache .. "/haunt_bookmarks/" .. vim.fn.getcwd()
    require("haunt.api").change_data_dir(project_bookmarks)
  end,
})

-- NormalBufferEnter loads git-conflicts, but for some reasons the conflicts are ignored so we also
-- have to force a refresh
vim.api.nvim_create_autocmd({ "User" },
  {
    pattern = "NormalBufferEnter",
    callback = function()
      vim.schedule(function()
        vim.cmd(':GitConflictRefresh')
      end)
    end
  })
