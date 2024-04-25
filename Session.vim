let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
let VM_check_mappings =  1 
let VM_mouse_mappings =  1 
let VM_default_mappings =  0 
let VM_persistent_registers =  0 
let NvimTreeSetup =  1 
let TabbyTabNames = "{\"3\":\"Git\",\"6\":\"Notes\",\"5\":\"Settings\",\"1\":\"Bootcamp\",\"2\":\"Mmsx\",\"4\":\"Fish\"}"
let NvimTreeRequired =  1 
let VM_highlight_matches = "underline"
silent only
silent tabonly
cd ~/dev/bootcamp
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +5 term://~/nvim-config//634405:/bin/fish
badd +1 fugitive:///home/ilan/nvim-config/.git//
argglobal
%argdel
$argadd ~/nvim-config/nvim/lua/config/mappings.vim
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit ilan/wordcount/wordcount.c
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 53 + 30) / 60)
exe 'vert 1resize ' . ((&columns * 106 + 106) / 213)
exe '2resize ' . ((&lines * 26 + 30) / 60)
exe 'vert 2resize ' . ((&columns * 106 + 106) / 213)
exe '3resize ' . ((&lines * 26 + 30) / 60)
exe 'vert 3resize ' . ((&columns * 106 + 106) / 213)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 78 - ((29 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 78
normal! 029|
wincmd w
argglobal
if bufexists(fnamemodify("~/nvim-config/nvim/lua/config/mappings.vim", ":p")) | buffer ~/nvim-config/nvim/lua/config/mappings.vim | else | edit ~/nvim-config/nvim/lua/config/mappings.vim | endif
if &buftype ==# 'terminal'
  silent file ~/nvim-config/nvim/lua/config/mappings.vim
endif
setlocal fdm=expr
setlocal fde=v:lua.vim.treesitter.foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 40 - ((10 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 40
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("term://~/dev/bootcamp//618613:/bin/fish", ":p")) | buffer term://~/dev/bootcamp//618613:/bin/fish | else | edit term://~/dev/bootcamp//618613:/bin/fish | endif
if &buftype ==# 'terminal'
  silent file term://~/dev/bootcamp//618613:/bin/fish
endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 021|
wincmd w
exe '1resize ' . ((&lines * 53 + 30) / 60)
exe 'vert 1resize ' . ((&columns * 106 + 106) / 213)
exe '2resize ' . ((&lines * 26 + 30) / 60)
exe 'vert 2resize ' . ((&columns * 106 + 106) / 213)
exe '3resize ' . ((&lines * 26 + 30) / 60)
exe 'vert 3resize ' . ((&columns * 106 + 106) / 213)
if exists(':tcd') == 2 | tcd ~/dev/bootcamp | endif
tabnext
edit ~/dev/mmsx-main/cbc/cbc-simulator.c
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 81 - ((37 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 81
normal! 045|
if exists(':tcd') == 2 | tcd ~/dev/mmsx-main | endif
tabnext
edit fugitive:///home/ilan/dev/bootcamp/.git//
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr=<<<<<<<<,>>>>>>>>
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
argglobal
if bufexists(fnamemodify("term://~/dev/bootcamp//557552:/bin/fish", ":p")) | buffer term://~/dev/bootcamp//557552:/bin/fish | else | edit term://~/dev/bootcamp//557552:/bin/fish | endif
if &buftype ==# 'terminal'
  silent file term://~/dev/bootcamp//557552:/bin/fish
endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 021|
tabnext
edit fugitive:///home/ilan/nvim-config/.git//
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 29 + 30) / 60)
exe '2resize ' . ((&lines * 29 + 30) / 60)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr=<<<<<<<<,>>>>>>>>
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 6 - ((5 * winheight(0) + 14) / 29)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 6
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("term://~/nvim-config//634405:/bin/fish", ":p")) | buffer term://~/nvim-config//634405:/bin/fish | else | edit term://~/nvim-config//634405:/bin/fish | endif
if &buftype ==# 'terminal'
  silent file term://~/nvim-config//634405:/bin/fish
endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 5 - ((4 * winheight(0) + 14) / 29)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
normal! 04|
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 29 + 30) / 60)
exe '2resize ' . ((&lines * 29 + 30) / 60)
if exists(':tcd') == 2 | tcd ~/nvim-config | endif
tabnext
edit ~/notes/tribal_knowledge.norg
argglobal
setlocal fdm=expr
setlocal fde=v:lua.vim.treesitter.foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
1
normal! zo
17
normal! zo
let s:l = 15 - ((14 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 060|
if exists(':tcd') == 2 | tcd ~/notes | endif
tabnext 5
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
