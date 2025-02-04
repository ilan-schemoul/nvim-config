return {
  -- "danielfalk/smart-open.nvim",
  -- NOTE: https://github.com/danielfalk/smart-open.nvim/pull/80/files
  "ilan-schemoul/smart-open.nvim",
  -- dir = "~/code/forks/smart-open.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  lazy = true,
  keys = {
    { "<leader>ll", function()
      require('telescope').extensions.smart_open.smart_open {
        cwd_only = true,
      }
    end },
    { "<leader>lL", "<cmd>Telescope smart_open<cr>" },
  },
  config = function(_, _)
    local cfg = require('telescope._extensions.smart_open.default_config').ignore_patterns
    local ignore_patterns_without_build = vim.tbl_filter(function(f)
      return f ~= "*build/*"
    end, cfg)

    local opts = {
      match_algorithm = "fzf",
      ignore_patterns = ignore_patterns_without_build,
    }
    require("smart-open").setup(opts)
    require("telescope").load_extension("smart_open")
  end,
}
