local config = require('config/config')

return {
  enabled = true,
  event = "InsertEnter",
  "milanglacier/minuet-ai.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    throttle = 1000,
    debounce = 300,
    virtualtext = {
      auto_trigger_ignore_ft = { "TelescopePrompt", "oil" },
      auto_trigger_ft = { "*" },
      keymap = {
        accept_line = '<A-d>',
        accept = '<A-f>',
        -- accept n lines (prompts for number)
        -- e.g. "A-z 2 CR" will accept 2 lines
        accept_n_lines = '<A-z>',
        -- Cycle to prev completion item, or manually invoke completion
        prev = '<A-' .. (config.keyboard == "fr" and "(" or "[") .. '>',
        -- Cycle to next completion item, or manually invoke completion
        next = '<A-' .. (config.keyboard == "fr" and ")" or "]") .. '>',
        dismiss = '<A-e>',
      },
      show_on_completion_menu = true,
    },
    provider = 'claude',
    n_completions = 2,
    context_window = 2000,
  }
}
