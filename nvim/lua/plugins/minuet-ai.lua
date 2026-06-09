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
        accept_line = '<A-d>',
        accept = '<A-f>',
        -- accept n lines (prompts for number)
        -- e.g. "A-z 2 CR" will accept 2 lines
        accept_n_lines = '<A-z>',
        -- Cycle to prev completion item, or manually invoke completion
        prev = '<A-(>',
        -- Cycle to next completion item, or manually invoke completion
        next = '<A-)>',
        dismiss = '<A-e>',
      },
      show_on_completion_menu = true,
    },
    provider = 'claude',
    n_completions = 1,
    context_window = 4000,
  }
}
