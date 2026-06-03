return {
  "GustavEikaas/easy-dotnet.nvim",
  cmd = { "Dotnet" },
  ft = { "cs" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "neovim/nvim-lspconfig"
  },
  opts = {
    lsp = {
      -- I hate it, it screws up my screen, keeps blinking, it's over popup
      auto_refresh_codelens = false,
      roslynator_enabled = false,
    },
    debugger = {
      mappings = {
        open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
      },
    },
    test_runner = {
      mappings = {
        run_test_from_buffer = { lhs = "<leader>*", desc = "run test from buffer" },
        run_all_tests_from_buffer = { lhs = "<leader>*", desc = "run all tests from buffer" },
        peek_stack_trace_from_buffer = { lhs = "<leader>*", desc = "peek stack trace from buffer" },

        -- Most useful. Inside buffer
        debug_test = { lhs = "<leader>d", desc = "debug test" },

        -- Inside testrunner view
        filter_failed_tests = { lhs = "<leader>f", desc = "filter failed tests" },
        go_to_file = { lhs = "g", desc = "go to file" },
        run_all = { lhs = "<leader>R", desc = "run all tests" },
        run = { lhs = "<leader>r", desc = "run test" },
        peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
        expand = { lhs = "o", desc = "expand" },
        expand_node = { lhs = "E", desc = "expand node" },
        expand_all = { lhs = "-", desc = "expand all" },
        collapse_all = { lhs = "W", desc = "collapse all" },
        close = { lhs = "q", desc = "close testrunner" },
        refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" }
      },
    },
  }
}

