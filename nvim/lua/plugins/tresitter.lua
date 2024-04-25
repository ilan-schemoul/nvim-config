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

        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["it"] = { query = "@type", desc = "Select type of a method/function/argument/assignment", lookbehind = true },

            -- You can use the capture groups defined in textobjects.scm
                ["o="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            -- Reversed order as "l" is a motion
            ["=l"] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["=r"] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

            ["oa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
            ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

            ["o,"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["i,"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
            ["o?"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["i?"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

            ["ol"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

            ["oc"] = { query = "@call.outer", desc = "Select outer part of a function call" },
            ["ic"] = { query = "@call.inner", desc = "Select inner part of a function call" },

            ["of"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
            ["if"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

            ["oo"] = { query = "@class.outer", desc = "Select outer part of a class" },
            ["io"] = { query = "@class.inner", desc = "Select inner part of a class" },

            ["ob"] = { query = "@block.outer" },
            ["ib"] = { query = "@block.inner" },

            ["or"] = { query = "@return.outer", desc = "Select outer part of return" },
            ["ir"] = { query = "@return.inner", desc = "Select inner part of return" },
        },
    },
    swap = {
        enable = true,
        swap_next = {
            [",sl"] = "@parameter.inner", -- swap parameters/argument with next
            [",sj"] = "@function.outer", -- swap function with next
        },
        swap_previous = {
            [",sh"] = "@parameter.inner", -- swap parameters/argument with next
            [",sk"] = "@function.outer", -- swap function with previous
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
    opts = {
        mode = "cursor",
        max_lines = 5,
        min_window_height = 40,
    },
},
}
