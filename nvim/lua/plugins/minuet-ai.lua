local is_intersec = require("config/utils").is_intersec()
local allow_cortex_use = false
local use_cortex = is_intersec and allow_cortex_use
local local_provider = 'codestral'

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

local cortex = {
  api_key = 'TERM',
  end_point = 'http://cortex.corp:11434/v1/completions',
  model = 'codestral:latest',
  name = 'Cortex',
  optional = {
    max_tokens = 70,
  },
}

return {
  enabled = os.getenv("NVIM_AI_ENABLE") ~= nil,
  event = "InsertEnter",
  "milanglacier/minuet-ai.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    throttle = 1000,
    debounce = 250,
    virtualtext = {
      auto_trigger_ignore_ft = { "TelescopePrompt" },
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
    provider = use_cortex and 'openai_fim_compatible' or local_provider,
    n_completions = use_cortex and 2 or 3,
    context_window = use_cortex and 8000 or 25000,
    provider_options = {
      codestral = {
        -- Two endpoints. API and codestral. Codestral requires subscription
        -- (which I don't want). So I use API (pay per tokens, but no
        -- subscription)
        end_point = 'https://api.mistral.ai/v1/fim/completions',
        api_key = 'CODESTRAL_API_KEY',
      },

      openai_fim_compatible = use_cortex and cortex or cloud_qwen,
    },
  }
}
