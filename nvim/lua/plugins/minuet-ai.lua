local is_intersec = require("config/utils").is_intersec()

local fim_endpoint = function(url)
  return 'https://' .. url .. '/v1/completions'
end

return {
  enabled = os.getenv("NVIM_AI_ENABLE") ~= nil,
  "milanglacier/minuet-ai.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
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
    provider = is_intersec and 'openai_fim_compatible' or 'codestral',
    n_completions = is_intersec and 2 or 3,
    context_window = is_intersec and 16000 or 4092,
    provider_options = {
      codestral = {
        end_point = 'https://api.mistral.ai/v1/fim/completions',
        template = require("config/fim_prompts").codestral_template,
      },

      openai_fim_compatible = {
        -- NOTE: modify all at once
        api_key = 'OPEN_ROUTER_API_KEY',
        end_point = fim_endpoint('openrouter.ai/api'),
        model = 'qwen/qwen-2.5-7b-instruct',

        name = 'Ollama',
        optional = {
          max_tokens = 56,
          top_p = 0.9,
        },
      },
    },
  }
}
