local Utils = require('config/utils')
local is_intersec = Utils.is_intersec()
local allow_cortex_use = false
local use_cortex = is_intersec and allow_cortex_use

return {
  enabled = true,
  event = "InsertEnter",
  "milanglacier/minuet-ai.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    throttle = 1000,
    debounce = 250,
    virtualtext = {
      auto_trigger_ignore_ft = { "TelescopePrompt", "oil" },
      auto_trigger_ft = { "*" },
      keymap = {
        accept_line = Utils.is_mac() and '<C-d>' or '<A-d>',
        accept = Utils.is_mac() and '<C-f>' or '<A-f>',
        -- accept n lines (prompts for number)
        -- e.g. "A-z 2 CR" will accept 2 lines
        accept_n_lines = Utils.is_mac() and '<C-z>' or '<A-z>',
        -- Cycle to prev completion item, or manually invoke completion
        prev = Utils.is_mac() and '<C-(>' or '<A-(>',
        -- Cycle to next completion item, or manually invoke completion
        next = Utils.is_mac() and '<C-)>' or '<A-)>',
        dismiss = Utils.is_mac() and '<C-e>' or '<A-e>',
      },
      show_on_completion_menu = true,
    },
    provider = 'claude',
    n_completions = use_cortex and 1 or 1,
    context_window = use_cortex and 8000 or 16000,
  }
}
