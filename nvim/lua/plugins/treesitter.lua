return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,

  opts = {
    -- textobjects = {
    --   select = {
    --     include_surrounding_whitespace = true,
    --     enable = true,
    --     lookahead = true,
    --     keymaps = {
    --       ["it"] = { query = "@type" },
    --
    --       ["in"] = { query = "@assignment.lhs" },
    --       ["iv"] = { query = "@assignment.rhs" },
    --
    --       ["aa"] = { query = "@parameter.outer" },
    --       ["ia"] = { query = "@parameter.inner" },
    --
    --       ["af"] = { query = "@function.outer" },
    --       ["if"] = { query = "@function.inner" },
    --
    --       ["ab"] = { query = "@block.outer" },
    --       ["ib"] = { query = "@block.inner" },
    --
    --       ["ir"] = { query = "@return.inner" },
    --     },
    --   },
    --   swap = {
    --     enable = true,
    --     swap_next = {
    --       ["<space>sl"] = "@parameter.inner", -- swap parameters/argument with next
    --       ["<space>sj"] = "@block.outer", -- swap function with next
    --     },
    --     swap_previous = {
    --       ["<space>sh"] = "@parameter.inner", -- swap parameters/argument with next
    --       ["<space>sk"] = "@block.outer", -- swap function with previous
    --     },
    --   },
    --   move = {
    --     enable = true,
    --     set_jumps = true,
    --     goto_next_start = {
    --       [")f"] = "@function.outer",
    --       [")b"] = "@block.outer",
    --     },
    --     goto_next_end = {
    --       [")F"] = "@function.outer",
    --       [")B"] = "@block.outer",
    --     },
    --     goto_previous_start = {
    --       ["(f"] = "@function.outer",
    --       ["(b"] = "@block.outer",
    --     },
    --     goto_previous_end = {
    --       ["(F"] = "@function.outer",
    --       ["(B"] = "@block.outer",
    --     },
    --   },
    -- },
  },
}
