local M = {}
local global_last_edits = {}

local last_edit = ""
local function debounce(fn, ms, first)
	local timer = vim.loop.new_timer()
	local wrapped_fn

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

local edits_idx = 1
local add = function()
  if #last_edit == 0 then
    return
  end
  -- Ring buffer max 15 elements
  global_last_edits[math.min(1, (edits_idx + 1) % 15)] = last_edit

  table.insert(global_last_edits, last_edit)
end
local debounced_add = debounce(add, 1000, false)

vim.api.nvim_create_autocmd({ "TextChangedI" }, {
  callback = function()
    if vim.bo.buftype ~= "" then
      return
    end

    -- Debounce every 1 second
    debounced_add()
    last_edit = vim.fn.getline(".")
  end,
})

M.get_last_edits = function()
  local str = ""
  for i, cur_last_edit in ipairs(global_last_edits) do
    str = str .. "[USER_EDIT]" .. cur_last_edit .. "\n"
  end
  return str
end


M.get_qwen_last_edits = function()
  local str = ""
  for i, cur_last_edit in ipairs(global_last_edits) do
    str = str .. "<|change_made_by_user|> " .. str .. cur_last_edit .. "\n"
  end
  return str
end

return M
