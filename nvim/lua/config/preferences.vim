colorscheme catppuccin-macchiato

autocmd BufEnter term://* startinsert " start in insert mode in terminal

set spelllang=en_us
set spellcapcheck=no
set spell
set spellsuggest=best,5

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

" scroll line by line (do not put this comment on the same line as the
" command)
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

let output = system("cd ~/nvim.ilanschemoul.me && git status --porcelain")
let g:seed = srand()
if rand(g:seed) % 100 > 90 && output != ""
   echohl WarningMsg | echo "The nvim git repository (~/nvim.ilanschemoul.me) is out of sync (must commit/push or pull)" | echohl None
endif

" Open file with cursor set to where last modification happened
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

hi CursorLineNr guifg=#aaaaaa
