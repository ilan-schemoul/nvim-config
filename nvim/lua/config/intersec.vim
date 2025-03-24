source /srv/tools/share/dotfiles/vim/syntax/c.vim

" Appending to path means letting priority to what is already in other
" folders of the path.
" We want the node already in path (what is sourced by the virtual
" environnement) takes precedence over node 20. But then otherwise I want
" modern node for LSP etc.
let $PATH = $PATH . '/home/ilan/.bin/node-v20.13.1-linux-x64/bin'

lua vim.filetype.add({ extension = { blk = 'c' } })

autocmd BufNewFile,BufRead wscript_build set filetype=python
au BufRead,BufNewFile behave_logs set filetype=behave_log

autocmd BufNewFile,BufRead *.iop set ft=iop
autocmd BufNewFile,BufRead *.cap set ft=xml

" Compilation
set makeprg=LC_ALL=C\ make\ MONOCHROME=1
set grepprg=git\ grep\ -H\ -n

" Patch errorformat to properly catch filenames in Z output
set errorformat^=:%*[\ ]%f:%l:\ %m

" Code formatting
set tabstop=4
set softtabstop=4
set expandtab
set textwidth=0
set shiftwidth=4
" Also update nvim/lua/plugins/smartcolumn.lua
set colorcolumn=78
" Enables breaking new lines automatically
autocmd FileType cpp,c,python,asciidoc,iop setl textwidth=78
autocmd FileType cucumber setl colorcolumn=0

set cinoptions=
set cinoptions+=L1s            " Align labels on previous indent level
set cinoptions+=:0             " Align case labels on previous indent level
set cinoptions+=g0             " same for C++ stuff
set cinoptions+=t0             " type on the line before the function is not indented
set cinoptions+=(0,Ws          " indent in functions ( ... ) when it breaks
set cinoptions+=m1             " align the closing ) properly
set cinoptions+=j1             " java/javascript -> fixes blocks
set cinoptions+=l1s            " align code after label ignoring braces.

" ASCII doc folding
function! AsciidocLevel()
    if getline(v:lnum) =~ '^== .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^=== .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^==== .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^===== .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^====== .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^======= .*$'
        return ">6"
    endif
    return "="
endfunction
au BufRead,BufNewFile *.adoc setlocal foldexpr=AsciidocLevel()
au BufRead,BufNewFile *.adoc setlocal foldmethod=expr
set foldlevel=99

" }}}
" {{{ Local vimrc

let g:localvimrc_name = ['.lvimrc', '.local_vimrc.vim']
let g:localvimrc_persistent = 2
let g:localvimrc_event = [ "BufWinEnter", "BufRead" ]

" disable sandboxing (the option makeprg that we set in waf localvimrcs cannot
" be set in a sandbox)
let g:localvimrc_sandbox = 0

" Whitelist ~/dev, which must contains all our repositories
let g:localvimrc_whitelist = $HOME.'/dev/'

lua require("config/intersec")
set spelllang=en_gb,programming,fr

