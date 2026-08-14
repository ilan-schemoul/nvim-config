set shell=fish

set clipboard+=unnamedplus

set visualbell
set termguicolors

" Metal gear
set textwidth=80
autocmd FileType gitcommit set textwidth=80
autocmd FileType markdown set textwidth=0
autocmd FileType cs set textwidth=140
autocmd FileType norg set textwidth=0

" More bright than the default one
highlight DiffChange guibg=#2b3148
" Less bright than default one
highlight ColorColumn ctermbg=0 guibg=#212337
highlight CursorLine guibg=#2a2c3f
highlight CursorLineNr guifg=#aaaaaa
highlight GitSignsAdd guifg=#3ce505
highlight GitSignsStagedAddNr guifg=#258e03
highlight GitSignsDelete guifg=#ed193a
highlight GitSignsStagedDeleteNr guifg=#ac0e26
highlight GitSignsChange guifg=#d7d803
highlight GitSignsStagedChangeNr guifg=#b0b102
highlight TreesitterContext guibg=#1c1e2e
highlight LspSignatureActiveParameter guifg=#ffaa00

lua << EOF
  require('config/api').ui.set_float_hl_by_filetype({
    ft_lazygit = {
      border = '#6c6f85'
    }
  })
EOF

let fg_var_color = synIDattr(synIDtrans(hlID("@variable.parameter")), "fg#")
execute 'highlight Hlargs guifg=' . fg_var_color

autocmd TermOpen * setlocal statuscolumn=""
autocmd TermOpen * setlocal nonumber norelativenumber

" Focus opens column line number which we don't want for terminals
autocmd TermOpen * lua vim.b.focus_disable = true
" HACK: ed
autocmd TermOpen * setlocal scrollback=20000
autocmd TermOpen * setlocal nospell
autocmd TermOpen,BufWinEnter,WinEnter,BufEnter term://* lua require("config/api").terminal.start_insert_if_bottom()

" PERF: autocommand enables spell when leaving terminal mode (10ms)
set spellcapcheck=no
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

autocmd FileType cs set tabstop=4
autocmd FileType cs set shiftwidth=4

set shiftround " round indent to multiples

set scrolloff=4 " minimum number of lines below and above cursor
set sidescrolloff=5 " columns to keep on right and left of cursor

set autoread " if the file changed outside reload it

set updatetime=300 " update interval of swap file (this value is useful for one package)

set list " tab as >, trailing whitespaces as ~, non breakable spaces as + (last one not working)
set listchars=tab:>-,trail:~,nbsp:+

set cursorline " hightlight current selected line

set undofile
set undodir=~/.vim/.undodir

set noswapfile

set numberwidth=1

" Sign column is always 2 cols width min. I do not like it at all.
" So I rewrote my status column (which can be 1 width).
set signcolumn=no
lua require('config/api').status_column.enable()

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

set fillchars=vert:\ ,vertleft:─,vertright:\ ,stl:─,stlnc:─
set statusline=─
highlight StatusLine guibg=transparent guifg=#acaeb5
highlight StatusLineNC guibg=transparent
highlight WinSeparator guifg=#383c51
highlight TabLineFill guibg=transparent

" Disable cursorline if not focused
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline

    " prev_state force status column to refresh
    au VimEnter * let b:prev_state = v:false
    au WinEnter * let b:prev_state = v:false
    au BufWinEnter * let b:prev_state = v:false

    au WinLeave * setlocal colorcolumn=""
augroup END

let &guicursor .= ',a:Cursor
                  \,t:ver80-TermCursor'

highlight TermCursor guibg=#babbf1

au BufRead,BufNewFile behave_logs set filetype=behave_log
colorscheme luna
highlight Normal guibg=#0A0A0A
highlight ColorColumn guibg=#080808
highlight @variable.parameter guifg=#b8b8b8
highlight TelescopeResultsTitle guibg=#8c9cb8 guifg=#060606
highlight TelescopePreviewTitle guibg=#605958 guifg=#e4e4e8
highlight TelescopePromptTitle guibg=#605958 guifg=#e4e4e8
