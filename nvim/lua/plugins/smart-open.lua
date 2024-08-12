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
    { "<leader>ll", "<cmd>Telescope smart_open<cr>" },
    { "<leader>lL", function()
      require('telescope').extensions.smart_open.smart_open {
        cwd_only = true,
      }
    end },
  },
  opts = {
    match_algorithm = "fzf",
  },
  config = function(_, opts)
    require("smart-open").setup(opts)
    require("telescope").load_extension("smart_open")
  end,
}
