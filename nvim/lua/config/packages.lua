local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = { pre_select = false },
}

require("lazy").setup({
  "tpope/vim-eunuch", -- unix helpers for other packages

  "907th/vim-auto-save",
  "preservim/nerdcommenter",

  "tpope/vim-fugitive", -- git

  "tpope/vim-surround",
  "mbbill/undotree",
  "mg979/vim-visual-multi", -- multiple cursor

  "dag/vim-fish",

  "romainl/vim-cool", -- disable search highlighting when you're done searching

  "glts/vim-magnum",
  "glts/vim-radical", -- cr{d/b/o/x} to modify the base of a number gA to see all bases

  "github/copilot.vim",

  "lewis6991/impatient.nvim",

  "luochen1990/rainbow",
  "HiPhish/rainbow-delimiters.nvim",

  "norcalli/nvim-colorizer.lua",
  "ggandor/leap.nvim", -- to jump to a part of code (click on s)

  "kyazdani42/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },

  { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate' },
  "nvim-treesitter/nvim-treesitter-context",

  "williamboman/mason.nvim",
  "RubixDev/mason-update-all",
  "williamboman/mason-lspconfig.nvim",

  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "mfussenegger/nvim-dap-python",

  "jose-elias-alvarez/null-ls.nvim",
  "jayp0521/mason-null-ls.nvim",

  "neovim/nvim-lspconfig",

  { "j-hui/fidget.nvim", tag = 'legacy' },

  "filipdutescu/renamer.nvim",

  { "ms-jpq/coq_nvim", branch = 'coq' },
  { "ms-jpq/coq.artifacts", branch = 'artifacts' },
  { "ms-jpq/coq.thirdparty", branch = '3p' },

  "BurntSushi/ripgrep",

  { "michaelb/sniprun", build = 'bash install.sh' },

  "weilbith/nvim-code-action-menu",

  "folke/trouble.nvim",

  "habamax/vim-godot",

  "romgrk/barbar.nvim", -- the top bar with buffer and tabs

  "ms-jpq/coq.thirdparty", -- to add copilot suggestion to coq

  "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- lsp errors on multiple lines
  "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",

  "nvim-tree/nvim-tree.lua",

  "ojroques/nvim-osc52", 

  "hrsh7th/nvim-cmp",

  "MunifTanjim/nui.nvim",
  "sudormrfbin/cheatsheet.nvim",

  "bennypowers/nvim-regexplainer",

  "RRethy/vim-illuminate",

  "stevearc/oil.nvim",

  "liuchengxu/vista.vim",

  "skywind3000/asynctasks.vim",

  "skywind3000/asyncrun.vim",

  "antoinemadec/FixCursorHold.nvim",
  "nvim-neotest/neotest",
  "nvim-neotest/neotest-python",
  "rouge8/neotest-rust",

  "catppuccin/nvim",

  {
	  "iamcco/markdown-preview.nvim",
	  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	  ft = { "markdown" },
	  build = function() vim.fn["mkdp#util#install"]() end,
  },

  "f-person/git-blame.nvim",

  "supercrabtree/vim-resurrect"
})
