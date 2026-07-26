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
    if (vim.bo.buftype == "terminal" or vim.bo.filetype == "lua") and vim.v.shell_error == 0 then
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
