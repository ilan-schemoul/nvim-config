local function disable(buf)
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  local utils = require("config/utils")

  if not ok or not stats then
    vim.notify("Cannot get stats for " .. vim.api.nvim_buf_get_name(buf), vim.log.levels.DEBUG)
    return true
  end

  if stats and stats.size > utils.max_treesitter_filesize then
    return true
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    dependencies = {
      -- They can't merge me feature as they wait for TS 1.0 before refactor evrerything
      { "ilan-schemoul/nvim-treesitter-textobjects", branch = "lookbehind-local-keymap-setting" },
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      ensure_installed = { "c", "markdown_inline", "regex", "markdown", "cpp", "rust" },
      sync_install = false,
      auto_install = true,
      ignore_install = { "zig", "asm" },

      highlight = {
        enable = true,
        indent = { enable = true },

        disable = function(_, buf)
          disable(buf)
        end,
      },

      textobjects = {
        select = {
          include_surrounding_whitespace = true,
          enable = true,
          lookahead = true,
          keymaps = {
            ["it"] = { query = "@type" },

            ["in"] = { query = "@assignment.lhs" },
            ["iv"] = { query = "@assignment.rhs" },

            ["aa"] = { query = "@parameter.outer" },
            ["ia"] = { query = "@parameter.inner" },

            ["af"] = { query = "@function.outer" },
            ["if"] = { query = "@function.inner" },

            ["ab"] = { query = "@block.outer" },
            ["ib"] = { query = "@block.inner" },

            ["ir"] = { query = "@return.inner" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<space>sl"] = "@parameter.inner", -- swap parameters/argument with next
            ["<space>sj"] = "@block.outer", -- swap function with next
          },
          swap_previous = {
            ["<space>sh"] = "@parameter.inner", -- swap parameters/argument with next
            ["<space>sk"] = "@block.outer", -- swap function with previous
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]b"] = "@block.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]B"] = "@block.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[b"] = "@block.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[B"] = "@block.outer",
          },
        },
      },
    },

    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
          ---@type table<string, boolean>
          local added = {}
          opts.ensure_installed = vim.tbl_filter(function(lang)
              if added[lang] then
                  return false
              end
              added[lang] = true
              return true
          end, opts.ensure_installed)
      end

      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Show context of the current function
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = true,
    disable = function(_, buf)
      disable(buf)
    end,
    opts = {
      mode = "cursor",
      max_lines = 5,
      min_window_height = 40,
    },
  },
}
