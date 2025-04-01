local alibaba = 'https://dashscope-intl.aliyuncs.com/compatible-mode/v1'
local cortex = ''
local url = require("config/utils").is_intersec() and cortex or alibaba
local provider = require("config/utils").is_intersec() and 'openai_fim_compatible' or 'openai_fim_compatible'

return {
  enabled = true,
  "milanglacier/minuet-ai.nvim",
  event = "InsertEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    debounce = 600,
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
    n_completions = 2,
    context_window = 512,
    provider = provider,
    provider_options  = {
      codestral = {
        end_point = 'https://api.mistral.ai/v1/fim/completions',
        template = require("config/fim_prompts").codestral_template,
      },
      gemini = require("config/fim_prompts").gemini_template,
      openai_fim_compatible = {
        api_key = 'ALIBABA_API_KEY',
        end_point = 'https://dashscope-intl.aliyuncs.com/compatible-mode/v1/completions',
        model = 'qwen2.5-coder:7b',
        optional = {
          max_tokens = 56,
          top_p = 0.9,
        },
        -- template = {
        --   prompt = function(context_before_cursor, context_after_cursor)
        --     return '<|fim_prefix|>'
        --     .. context_before_cursor
        --     .. '<|fim_suffix|>'
        --     .. context_after_cursor
        --     .. '<|fim_middle|>'
        --   end,
        --   optional = {
        --     max_tokens = 256,
        --     stop = { '\n\n' },
        --   },
        --   suffix = false,
        -- },
      },
      -- openai_fim_compatible  = {
      --   name = "qwen",
      --   api_key = "ALIBABA_API_KEY",
      --   -- template = require("config/fim_prompts").qwen_cacher_template,
      --   end_point = url,
      --   model = 'qwen2.5-coder:7b',
      --   -- optional = {
      --   --   max_tokens = 256,
      --   --   stop = { '\n\n' },
      --   -- },
      -- },
    }
  },
}
