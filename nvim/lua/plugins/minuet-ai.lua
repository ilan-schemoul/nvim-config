local cloud = 'https://dashscope-intl.aliyuncs.com/compatible-mode/v1'
local cortex = ''
local url = require("config/utils").is_intersec() and cortex or cloud
local provider = require("config/utils").is_intersec() and 'openai_fim_compatible' or 'codestral'

local opts = {
  enabled = os.getenv("NVIM_AI_ENABLE"),
  "milanglacier/minuet-ai.nvim",
  event = "InsertEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    debounce = 200,
    throttle = 1000,
    virtualtext = {
      auto_trigger_ft = { "*" },
      keymap = {
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
        template = require("config/fim_prompts").codestral_template,
      },
      gemini = require("config/fim_prompts").gemini_template,
    }
  },
}

if require("config/utils").is_intersec() then
  opts.opts.provider_options.openai_fim_compatible = {
    template = require("config/fim_prompts").qwen_cacher_template,
    end_point = url,
    model = 'qwen2.5-coder:7b',
    optional = {
      max_tokens = 256,
      stop = { '\n\n' },
    },
  }
end

return opts
