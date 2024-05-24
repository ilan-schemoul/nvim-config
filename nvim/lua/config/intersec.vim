let $PATH = '/home/ilan/.bin/node-v20.13.1-linux-x64/bin:' . $PATH

lua vim.filetype.add({ extension = { blk = 'c' } }) 

autocmd BufNewFile,BufRead wscript_build set filetype=python

autocmd BufNewFile,BufRead behave_logs,behave_steps_output set filetype=log
autocmd BufNewFile,BufRead behave_logs,behave_steps_output set autoread

fun! s:reload_logs(_)
    if expand('%:t') == "behave_logs" || expand('%:t') == "behave_steps_output"
        exec("edit")
    endif
endfun

" call timer_start(1000, function('s:reload_logs'), {'repeat': -1})
autocmd BufNewFile,BufRead behave_steps_output set ft=cucumber

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

set colorcolumn=78

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

map <Leader>gf :G push-for<cr>
