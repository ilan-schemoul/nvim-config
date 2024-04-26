require("config/init-lazy")

require("lazy").setup({
  -- SnipRun.lua, chatgpt.lua, coq.lua, hypersonic.lua, lsp.lua, neorg.lua, tresitter.lua, vim-visual-multi.lua
  { import = "plugins" }, -- imports ~/.config/nvim/lua/plugins/*.lua

  "tpope/vim-eunuch", -- unix helpers for other packages

  "tpope/vim-fugitive", -- git

  "tpope/vim-surround",
  "mbbill/undotree",

  "dag/vim-fish",

  "romainl/vim-cool", -- disable search highlighting when you're done searching

  "glts/vim-magnum",
  "glts/vim-radical", -- cr{d/b/o/x} to modify the base of a number gA to see all bases

  { "HiPhish/rainbow-delimiters.nvim", event = { "BufReadPre", "BufNewFile" } },

  "norcalli/nvim-colorizer.lua",

  "nvim-tree/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  "j-hui/fidget.nvim",

  "filipdutescu/renamer.nvim",

  "BurntSushi/ripgrep",

  "weilbith/nvim-code-action-menu",

  "folke/trouble.nvim",

  "habamax/vim-godot",

  "ojroques/nvim-osc52",

  "MunifTanjim/nui.nvim",

  { "RRethy/vim-illuminate", event = { "BufReadPre", "BufNewFile" } },

  "liuchengxu/vista.vim",

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  "supercrabtree/vim-resurrect",

  {
    "ThePrimeagen/harpoon",
    version = "ccae1b9bec717ae284906b0bf83d720e59d12b91", -- v1
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  "max397574/better-escape.nvim",

  { "tpope/vim-sleuth", enabled = false }, -- adjusts shiftwidth/expandtab based on other files
  "embear/vim-localvimrc",
  "glacambre/firenvim",
  "nvim-telescope/telescope-live-grep-args.nvim",
  "folke/which-key.nvim",
}, { change_detection = { enabled = true, notify = false } })
