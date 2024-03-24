if executable("fish")
  set shell=/bin/fish
else
  set shell=/bin/bash
endif

set mouse=a
set clipboard+=unnamedplus

syntax enable
filetype plugin indent on 
set encoding=utf-8

" https://medium.com/usevim/vim-101-set-hidden-f78800142855
set hidden
set ttyfast
set visualbell
set t_vb=

vnoremap p "_dP " nocopy when pasting 

if (has("termguicolors"))
  set termguicolors
endif

set ttimeout
set ttimeoutlen=100
set timeoutlen=700

if has("multi_byte")
  if &encoding !~? '^u'
    if &termencoding == ""
      let &termencoding = &encoding
    endif
    set encoding=utf-8
  endif
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

