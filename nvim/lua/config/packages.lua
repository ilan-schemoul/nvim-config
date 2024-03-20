require("config/init-lazy")

require("lazy").setup({
  { import = "plugins" }, -- imports ~/.config/nvim/lua/plugins/*.lua

  "tpope/vim-eunuch",     -- unix helpers for other packages

  "907th/vim-auto-save",
  "preservim/nerdcommenter",

  "tpope/vim-fugitive", -- git

  "tpope/vim-surround",
  "mbbill/undotree",
  -- multiple cursor

  "dag/vim-fish",

  "romainl/vim-cool", -- disable search highlighting when you're done searching

  "glts/vim-magnum",
  "glts/vim-radical", -- cr{d/b/o/x} to modify the base of a number gA to see all bases

  { "HiPhish/rainbow-delimiters.nvim", event = { "BufReadPre", "BufNewFile" } },

  "norcalli/nvim-colorizer.lua",
  "ggandor/leap.nvim", -- to jump to a part of code (click on s)

  "kyazdani42/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },

  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "mfussenegger/nvim-dap-python",

  "j-hui/fidget.nvim",

  "filipdutescu/renamer.nvim",

  "BurntSushi/ripgrep",

  "weilbith/nvim-code-action-menu",

  "folke/trouble.nvim",

  "habamax/vim-godot",

  "nvim-tree/nvim-tree.lua",

  "ojroques/nvim-osc52",

  "MunifTanjim/nui.nvim",

  { "RRethy/vim-illuminate",                    event = { "BufReadPre", "BufNewFile" } },

  { "romgrk/barbar.nvim",                       event = { "BufReadPost", "BufNewFile" }, VeryLazy = true },
  "stevearc/oil.nvim",

  "liuchengxu/vista.vim",

  "skywind3000/asynctasks.vim",
  "skywind3000/asyncrun.vim",

  "antoinemadec/FixCursorHold.nvim",
  "nvim-neotest/neotest",
  "nvim-neotest/nvim-nio",
  "nvim-neotest/neotest-python",
  "rouge8/neotest-rust",

  "catppuccin/nvim",

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  "supercrabtree/vim-resurrect",

  {
    "ThePrimeagen/harpoon",
    version = "ccae1b9bec717ae284906b0bf83d720e59d12b91", -- v1
    requires = { "nvim-lua/plenary.nvim" }
  },

  "max397574/better-escape.nvim",

  "tpope/vim-sleuth", -- adjusts shiftwidth/expandtab based on other files

  { dir = "~/code/forks/ChatGPT.nvim" },
}, { change_detection = { enabled = false } })
