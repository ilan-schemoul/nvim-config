return {
  "ThePrimeagen/refactoring.nvim",
  keys = {
    -- extract functions
    { "<leader>ref", "<cmd>Refactor extract <cr>", mode = "x" },
    { "<leader>reF", "<cmd>Refactor extract_to_file <cr>", mode = "x" },

    { "<leader>rev", "<cmd>Refactor extract_var <cr>", mode = { "n", "x" } },
    { "<leader>riv", "<cmd>Refactor inline_var<cr>", mode = { "n", "x" } },

    { "<leader>rif", "<cmd>Refactor inline_func<cr>", mode = "n" },

    { "<leader>reb", "<cmd>Refactor extract_block<cr>", mode = "n" },
    { "<leader>reF", "<cmd>Refactor extract_block_to_file<cr>", mode = "n" },
    {
      mode = "n",
      "<leader>rpl",
      function()
        require("refactoring").debug.printf({ below = true })
      end,
    },

    {
      mode = { "x", "n" },
      "<leader>rpv",
      function()
        require("refactoring").debug.print_var()
      end,
    },

    {
      mode = "n",
      "<leader>rpc",
      function()
        require("refactoring").debug.cleanup({})
      end,
    },
  },
  opts = {
    prompt_func_return_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
    },
  },
}
