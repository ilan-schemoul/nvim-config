local cloud = 'https://dashscope-intl.aliyuncs.com/compatible-mode/v1'
local cortex = ''
local url = require("config/utils").is_intersec() and cortex or cloud
local provider = require("config/utils").is_intersec() and 'openai_fim_compatible' or 'codestral'

local opts = {
  "milanglacier/minuet-ai.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- TODO: qwen API
  -- TODO: vector code
  opts = {
    debounce = 120,
    throttle = 800,
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
  },
}

if require("config/utils").is_intersec() then
  opts.opts.provider_options = {
    openai_fim_compatible = {
      end_point = url,
      model = 'qwen2.5-coder:7b',
    },
    optional = {
      max_tokens = 256,
      stop = { '\n\n' },
    },
  }
end

return opts
