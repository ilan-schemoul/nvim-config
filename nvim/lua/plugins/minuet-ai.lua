return {
  enabled = os.getenv("CODESTRAL_API_KEY"),
  "milanglacier/minuet-ai.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- TODO: qwen API
  -- TODO: vector code
  opts = {
    virtualtext = {
        auto_trigger_ft = { "*" },
        keymap = {
            -- TODO: stop monopilizing TAB like that
            accept = '<Tab>',
            accept_line = '<A-a>',
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
    provider = 'codestral',
  },
}
