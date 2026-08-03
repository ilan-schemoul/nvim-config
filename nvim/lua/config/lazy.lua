vim.g.mapleader = " "
vim.g.maplocalleader = "g"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local event = require("lazy.core.handler.event")
event.mappings.NormalBufferEnter = {
  id = "NormalBufferEnter",
  event = "User",
  pattern = "NormalBufferEnter",
}

local normal_buffer_enter_id
normal_buffer_enter_id = vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  callback = function()
    local normal_buftype = ''
    if vim.bo.buftype == normal_buftype and vim.api.nvim_buf_get_name(0) ~= "" then
      vim.api.nvim_exec_autocmds("User", { pattern = "NormalBufferEnter" })
      vim.api.nvim_del_autocmd(normal_buffer_enter_id)
    end
  end
})

require("lazy").setup({
  spec = {
      { import = "plugins" },
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
  -- Toggle if need more precise profiling (slightly slower)
  profiling = {
    loader = false,
    require = false,
  },
  performance = {
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

