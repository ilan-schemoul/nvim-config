call plug#begin()
  Plug 'tpope/vim-eunuch' " unix helpers for other packages

  Plug '907th/vim-auto-save'
  Plug 'preservim/nerdcommenter'

  Plug 'tpope/vim-fugitive' " git

  Plug 'tpope/vim-surround'
  Plug 'mbbill/undotree'
  Plug 'mg979/vim-visual-multi' " multiple cursor

  Plug 'dag/vim-fish'

  Plug 'romainl/vim-cool' " disable search highlighting when you're done searching

  Plug 'glts/vim-magnum' " necessary for below
  Plug 'glts/vim-radical' " cr{d/b/o/x} to modify the base of a number gA to see all bases

  Plug 'github/copilot.vim'

  if !has("nvim")
    Plug 'ghifarit53/tokyonight-vim' " beautiful colorscheme
  end

  if has("nvim")
    Plug 'lewis6991/impatient.nvim'

    " Plug 'luochen1990/rainbow'
    Plug 'HiPhish/rainbow-delimiters.nvim'

    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'ggandor/leap.nvim' " to jump to a part of code (click on s)
    " --- neo vim specific below
    " telescope related
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'

    Plug 'williamboman/mason.nvim'
    Plug 'RubixDev/mason-update-all'
    Plug 'williamboman/mason-lspconfig.nvim'

    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'mfussenegger/nvim-dap-python'

    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'jayp0521/mason-null-ls.nvim'

    Plug 'neovim/nvim-lspconfig'

    Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }

    Plug 'filipdutescu/renamer.nvim'

    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

    Plug 'BurntSushi/ripgrep'

    Plug 'michaelb/sniprun', {'do': 'bash install.sh'} " to see the result of the execution of a code

    Plug 'weilbith/nvim-code-action-menu'

    Plug 'folke/trouble.nvim'

    Plug 'habamax/vim-godot'

    Plug 'romgrk/barbar.nvim' " the top bar with buffer and tabs

    Plug 'ms-jpq/coq.thirdparty' " to add copilot suggestion to coq

    Plug 'folke/tokyonight.nvim' " beautiful colorscheme

    Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' " lsp errors on multiple lines
    Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'

    Plug 'nvim-tree/nvim-tree.lua'

    Plug 'ojroques/nvim-osc52' " to 

    Plug 'hrsh7th/nvim-cmp' " needed for obsidian

    Plug 'MunifTanjim/nui.nvim'
    Plug 'sudormrfbin/cheatsheet.nvim'

    Plug 'bennypowers/nvim-regexplainer'

    Plug 'RRethy/vim-illuminate'

    Plug 'stevearc/oil.nvim'

    Plug 'liuchengxu/vista.vim'

    Plug 'skywind3000/asynctasks.vim'

    Plug 'skywind3000/asyncrun.vim'

    " Dependency of below
    Plug 'antoinemadec/FixCursorHold.nvim'
    Plug 'nvim-neotest/neotest'
    Plug 'nvim-neotest/neotest-python'

    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  end
call plug#end()

