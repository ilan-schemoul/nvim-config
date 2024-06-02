vim.g.mapleader = " "
vim.cmd("map , <Space>")
vim.g.maplocalleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Add support for the LazyFile event
local Event = require("lazy.core.handler.event")

-- We'll handle delayed execution of events ourselves
Event.mappings.LazyFile = { id = "LazyFile", event = "User", pattern = "LazyFile" }
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

local events = {} ---@type {event: string, buf: number, data?: any}[]

local done = false
local function load()
  if #events == 0 or done then
    return
  end
  done = true
  vim.api.nvim_del_augroup_by_name("lazy_file")

  ---@type table<string,string[]>
  local skips = {}
  for _, event in ipairs(events) do
    skips[event.event] = skips[event.event] or Event.get_augroups(event.event)
  end

  vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile", modeline = false })
  for _, event in ipairs(events) do
    if vim.api.nvim_buf_is_valid(event.buf) then
      Event.trigger({
        event = event.event,
        exclude = skips[event.event],
        data = event.data,
        buf = event.buf,
      })
      if vim.bo[event.buf].filetype then
        Event.trigger({
          event = "FileType",
          buf = event.buf,
        })
      end
    end
  end
  vim.api.nvim_exec_autocmds("CursorMoved", { modeline = false })
  events = {}
end

-- schedule wrap so that nested autocmds are executed
-- and the UI can continue rendering without blocking
load = vim.schedule_wrap(load)

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("lazy_file", { clear = true }),
  callback = function(event)
    table.insert(events, event)
    load()
  end,
})

local lock_file = "lazy-lock-default.json"
if os.getenv("IS_INTERSEC") == "true" then
  lock_file = "lazy-lock-intersec.json"
end

require("lazy").setup("plugins", {
  change_detection = {
    enabled = true,
    notify = false,
  },
  lockfile = vim.fn.stdpath("config") .. lock_file
})
