if executable("fish")
  set shell=/bin/fish
else
  set shell=/bin/bash
endif

set clipboard+=unnamedplus

set visualbell
set termguicolors

colorscheme catppuccin-macchiato

lua << EOF
vim.api.nvim_create_autocmd({"InsertLeave"}, {
  callback = function(args)
    buf = vim.api.nvim_win_get_buf(0)

    if vim.bo[buf].readonly then
      vim.notify("Cannot save. Use :TeeSave.", "warn")
    end
  end,
})
EOF

" More bright than default one
highlight DiffChange guibg=#2b3148
" Less bright than default one
highlight ColorColumn ctermbg=0 guibg=#212337
highlight CursorLineNr guifg=#aaaaaa
highlight GitSignsAdd guifg=#4d783f
highlight GitSignsDelete guifg=#79323d
highlight GitSignsChange guifg=#9c9d0d
" White instead of Yellow
highlight DashboardFooter cterm=italic gui=italic guifg=#6e738d

" nocopy when pasting
xnoremap <expr> p 'pgv"' . v:register . 'y'
xnoremap <expr> x 'xgv"' . v:register . 'y'

autocmd TermOpen * setlocal nonumber norelativenumber
" Focus opens column line number which we don't want for terminals
autocmd TermOpen * lua vim.b.focus_disable = true
autocmd TermOpen * setlocal scrollback=10000
autocmd TermOpen * setlocal nospell
autocmd TermOpen,BufWinEnter,WinEnter,BufEnter term://* lua _G.StartInsertIfBottom()

set spelllang=en_us,programming,fr
set spellcapcheck=no
set spell
set spellsuggest=best,5

set magic " No need to escape in regex

set modelines=0 " modelines allows to enable options in a file with special comments

set laststatus=0 " no bar at the bottom
set cmdheight=0 " hide command line when not used

set backspace=indent,eol,start " allows backspacing over everything in insert mode

set incsearch " jumps to search word as you type
set wildignore=*.o,*.obj,*.bak,*.ex

set ignorecase " case unsensitive if all lowercase in the search
set smartcase " case sensitive if one letter is uppercase

set smartindent
set autoindent " when create newline use indent from current line
set smarttab " better insertion, deletes as much spaces as one tab size
set expandtab " use spaces not tabs
autocmd FileType gdscript set expandtab

set tabstop=2 " number of spaces a tab is
set shiftwidth=2 " number of spaces when using >> and autoindent
set shiftround " round indent to multiples
set signcolumn=no " show in the same column as the numbers, hide if no signs (like auto option)

set scrolloff=4 " minimum number of lines below and above cursor
set sidescrolloff=5 " columns to keep on right and left of cursor

set autoread " if the file changed outside reload it

set updatetime=300 " update interval of swap file (this value is useful for one package)

set list " tab as >, trailing whitespaces as ~, non breakable spaces as + (last one not working)
set listchars=tab:>-,trail:~,nbsp:+

set cursorline " hightlight current selected line

set undofile
set undodir=~/.vim/.undodir

set number relativenumber
set numberwidth=1

" Open file with cursor set to where last modification happened
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

set sessionoptions=buffers,curdir,folds,globals,help,tabpages,terminal,winsize

set nofoldenable

autocmd BufNewFile,BufRead *.iop set ft=iop

autocmd FileType behave_log setlocal foldmethod=expr
autocmd FileType behave_log setlocal foldexpr=getline(v:lnum)=~'.*When\\\|Then\\\|Given.*'?'>1':1
" FIXME: currently disabled while fold is buggy
" autocmd FileType behave_log setlocal foldenable
