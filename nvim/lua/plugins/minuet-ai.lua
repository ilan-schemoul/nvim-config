local is_intersec = require("config/utils").is_intersec()

local fim_endpoint = function(url)
  return 'https://' .. url .. '/v1/completions'
end

local cloud_qwen = {
  api_key = 'NEBIUS_API_KEY',
  end_point = fim_endpoint('api.studio.nebius.com'),
  model = 'Qwen/Qwen2.5-Coder-7B',

  name = 'Qwen',
  optional = {
    max_tokens = 56,
    top_p = 0.9,
  },
}

local cortex_qwen = {
  api_key = 'TERM',
  -- FIXME:
  end_point = fim_endpoint('cortex.corp'),
  -- FIXME:
  model = 'qwen2.5-coder:7b',

  name = 'Cortex qwen',
  optional = {
    max_tokens = 56,
    top_p = 0.9,
  },
}

return {
  enabled = os.getenv("NVIM_AI_ENABLE") ~= nil,
  "milanglacier/minuet-ai.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    throttle = 800,
    debounce = 250,
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
    context_window = is_intersec and 4092 or 14000,
    provider_options = {
      codestral = {
        end_point = 'https://api.mistral.ai/v1/fim/completions',
      },

      openai_fim_compatible = is_intersec and cortex_qwen or cloud_qwen,
    },
  }
}
