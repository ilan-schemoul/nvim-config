return {
  "danielfalk/smart-open.nvim",
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
    end, desc = "Smart open file (cwd)" },
    { "<leader>lL", "<cmd>Telescope smart_open<cr>", desc = "Smart open file" },
  },
  config = function(_, _)
    local opts = {
      match_algorithm = "fzf",
    }
    require("smart-open").setup(opts)
    require("telescope").load_extension("smart_open")
  end,
}
