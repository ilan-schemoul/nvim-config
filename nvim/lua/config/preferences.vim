set clipboard+=unnamedplus

set visualbell
set termguicolors

set colorcolumn=80

colorscheme catppuccin-macchiato

" More bright than the default one
highlight DiffChange guibg=#2b3148
" Less bright than default one
highlight ColorColumn ctermbg=0 guibg=#212337
highlight CursorLineNr guifg=#aaaaaa
highlight GitSignsAdd guifg=#279403
highlight GitSignsDelete guifg=#b60e28
highlight GitSignsChange guifg=#d7d803

autocmd TermOpen * setlocal statuscolumn=""
autocmd TermOpen * setlocal nonumber norelativenumber

" Focus opens column line number which we don't want for terminals
autocmd TermOpen * lua vim.b.focus_disable = true
" XXX: change the value in mappings <C-q> as well
autocmd TermOpen * setlocal scrollback=5000
autocmd TermOpen * setlocal nospell
autocmd TermOpen,BufWinEnter,WinEnter,BufEnter term://* lua require("config/custom-commands").start_insert_if_bottom()

set spelllang=en_us,programming,fr
set spellcapcheck=no
set spell
set spellsuggest=best,5

set magic " No need to escape in regex

set modelines=0 " modelines allows to enable options in a file with special comments

set laststatus=0 " no bar at the bottom
set cmdheight=0 " hide command line when not used

set backspace=indent,eol,start " allows backspacing over everything in insert mode

" Show the modification of text that are not visible in a split buffer
set inccommand=split
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

set nofoldenable " By default open all folds
set foldmethod=marker " {{{/}}}

" make a copy of the file and overwrite the original one
" necessary for parcel
set backupcopy=yes

set backup
set backupdir=~/.vim/.backupdir

" https://vi.stackexchange.com/questions/5128/matchpairs-makes-vim-slow/5318#5318
let g:matchparen_timeout = 2
let g:matchparen_insert_timeout = 2

" One straight horizontal line between windows
" set laststatus=3

" Hidden by default
" set statuscolumn="%l"
" set nonumber
" set norelativenumber

lua require("config/utils").setup_separators()
set fillchars=vert:\ ,vertleft:─,vertright:\ ,stl:─,stlnc:─
set statusline=─
highlight StatusLine guibg=transparent guifg=#acaeb5
highlight StatusLineNC guibg=transparent
highlight WinSeparator guifg=#383c51
highlight TabLineFill guibg=transparent
hi Normal guibg=#24273b
hi NormalNC guibg=#222538 guifg=#b5bed3

" Disable cursorline if not focused
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline

    au VimEnter * setlocal colorcolumn=+0
    au WinEnter * setlocal colorcolumn=+0
    au BufWinEnter * setlocal colorcolumn=+0
    au WinLeave * setlocal colorcolumn=""
augroup END

au BufRead,BufNewFile behave_logs set filetype=behave_log
