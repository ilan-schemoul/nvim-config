local cloud = 'https://dashscope-intl.aliyuncs.com/compatible-mode/v1'
local cortex = ''
local url = require("config/utils").is_intersec() and cortex or cloud
local provider = require("config/utils").is_intersec() and 'openai_fim_compatible' or 'codestral'

local global_last_edits = {}

local function get_last_edits()
  local str = "[USER EDITS]\n"
  for i, last_edit in ipairs(global_last_edits) do
    str = str .. last_edit .. "\n"
  end
  return str
end


local function get_qwen_last_edits()
  local str = ""
  for i, last_edit in ipairs(global_last_edits) do
    str = str .. "<|change_made_by_user|> " .. str .. last_edit .. "\n"
  end
  return str
end

local function prequire(m)
  local ok, err = pcall(require, m)
  if not ok then return nil, err end
  return err
end

local get_cache = function()
  local cacher_config = prequire("vectorcode.config")

  if cacher_config then
    local cacher = cacher_config.get_cacher_backend()
    return cacher.query_from_cache(0)
  end

  return nil
end


local qwen_cacher_template = {
    prompt = function(pref, suff)
      local prompt_message = ''

      local cache = get_cache()
      if cache then
        for _, file in ipairs(cache.query_from_cache(0)) do
          prompt_message = prompt_message .. '<|file_sep|>' .. file.path .. '\n' .. file.document
        end
      end

      prompt_message = prompt_message .. get_qwen_last_edits()
      local prompt = prompt_message .. '<|fim_prefix|>' .. pref .. '<|fim_suffix|>' .. suff .. '<|fim_middle|>'
      return prompt
    end,
    suffix = false,
}

local codestral_template = {
  prompt = function(pref, suff)
    -- TODO: bring back Content that follows [USER EDITS] are lines inserted by user recently. Make use of them if necessary.
     local prompt_message = ("Perform fill in the middle completion in the language %s based on the following content.\n"):gsub("%%s", vim.bo.filetype)

    local cache_result = get_cache()
    if cache_result and #cache_result > 0 then
      prompt_message = prompt_message .. "Content that follows `[CONTEXT]` is a file in the repository that may be useful. Make use of them where necessary. \n"
      for _, file in ipairs(cache_result) do
        prompt_message = prompt_message .. "[CONTEXT]" .. file.path .. "\n" .. file.document
      end
    end

    -- XXX:
    -- prompt_message = prompt_message .. get_last_edits()
    local prompt =  prompt_message
                  .. " [PREFIX] " .. pref
                  .. " [SUFFIX] " .. suff
                  .. " [MIDDLE]"
    return prompt
  end,
  suffix = false,
}

local last_edit = ""
function debounce(fn, ms, first)
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
  print(vim.inspect(global_last_edits))
end
local debounced_add = debounce(add, 1000, false)

--
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

local opts = {
  enabled = os.getenv("NVIM_AI_ENABLE"),
  "milanglacier/minuet-ai.nvim",
  event = "InsertEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- TODO: qwen API
  -- TODO: vector code
  opts = {
    debounce = 200,
    throttle = 1000,
    virtualtext = {
      auto_trigger_ft = { "*" },
      keymap = {
        -- TODO: stop monopilizing TAB like that
        accept_line = '<A-d>',
        accept = '<A-f>',
        -- accept n lines (prompts for number)
        -- e.g. "A-z 2 CR" will accept 2 lines
        accept_n_lines = '<A-z>',
        -- Cycle to prev completion item, or manually invoke completion
        prev = '<A-[>',
        -- Cycle to next completion item, or manually invoke completion
        next = '<A-]>',
        dismiss = '<A-e>',
      },
      show_on_completion_menu = true,
    },
    n_completions = 3,
    context_window = 16000,
    provider = provider,
    provider_options = {
      codestral = {
        end_point = 'https://api.mistral.ai/v1/fim/completions',
        template = codestral_template,
      },
      gemini = {
        system = {
          template = '{{{prompt}}}\n{{{guidelines}}}\n{{{n_completion_template}}}\n{{{repo_context}}}\n{{{last_edits}}}',
          repo_context = [[9. Additional context from other files in the repository will be enclosed in <repo_context> tags. Each file will be separated by <file_separator> tags, containing its relative path and content.]],
        },
        chat_input = {
          template = '{{{last_edits}}}\n{{{repo_context}}}\n{{{language}}}\n{{{tab}}}\n<contextBeforeCursor>\n{{{context_before_cursor}}}<cursorPosition>\n<contextAfterCursor>\n{{{context_after_cursor}}}',
          last_edits = function(_, _)
            return '<last_edits>\n' .. get_last_edits() .. '\n</last_edits>'
          end,
          repo_context = function(_, _, _)
            local cache_result = get_cache()
            local prompt_message = ''
            if cache_result then
              for _, file in ipairs(cache_result) do
                prompt_message = prompt_message
                .. '<file_separator>'
                .. file.path
                .. '\n'
                .. file.document
              end
            end
            if prompt_message ~= '' then
              prompt_message = '<repo_context>\n' .. prompt_message .. '\n</repo_context>'
            end
            return prompt_message
          end,
        },
      },
    }
  },
}

if require("config/utils").is_intersec() then
  opts.opts.provider_options.openai_fim_compatible = {
    template = qwen_cacher_template,
    end_point = url,
    model = 'qwen2.5-coder:7b',
    optional = {
      max_tokens = 256,
      stop = { '\n\n' },
    },
  }
end

return opts
