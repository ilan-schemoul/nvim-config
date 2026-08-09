-- https://gist.githubusercontent.com/runiq/31aa5c4bf00f8e0843cd267880117201/raw/82da0bb4e3e1182d0a087910bc3c8a3f19edb395/defer.lua
--
M = {}

function M.throttle_leading(fn, ms)
  local timer = vim.loop.new_timer()
  local running = false

  assert(timer)

  local function wrapped_fn(...)
    if not running then
      timer:start(ms, 0, function()
        running = false
      end)
      running = true
      pcall(vim.schedule_wrap(fn), select(1, ...))
    end
  end
  return wrapped_fn, timer
end

function M.debounce_trailing(fn, ms, first)
  local timer = vim.loop.new_timer()
  local wrapped_fn

  assert(timer)

  if not first then
    function wrapped_fn(...)
      local argv = {...}
      local argc = select('#', ...)

      timer:start(ms, 0, function()
        pcall(vim.schedule_wrap(fn), unpack(argv, 1, argc))
      end)
    end
  else
    local argv, argc
    function wrapped_fn(...)
      argv = argv or {...}
      argc = argc or select('#', ...)

      timer:start(ms, 0, function()
        pcall(vim.schedule_wrap(fn), unpack(argv, 1, argc))
      end)
    end
  end
  return wrapped_fn, timer
end

return M
