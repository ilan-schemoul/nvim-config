" Mappings defined by plugins
" gA to see all bases for a number under the cursor cr{b/x/d/o} to change a
" number base
" s{char1}{char2}{label} to jump to a word (leap)

" toggle relativenumber + number. It shows on the left column the number
" of the current line and the relative number of lines aboves and below
map ,I :set invrelativenumber<CR>
map ,N :set invnumber<CR>

map ,S :call ToggleSignColumn()<CR>
map ,E :lua require("lsp_lines").toggle()<CR>

" allows to choose a buffer in the top bar with dynamic keyboards shorcut
map ,p <Cmd>BufferPick<CR>

" closes everything
map ,q :q<CR>
map ,Q :wqa!<CR>

" toggle the tree files on the left
map ,t :NvimTreeToggle<CR>

map ,f :lua vim.lsp.buf.format{async=true}<CR>
map ,D :lua vim.diagnostic.open_float()<CR>
map ,h :lua vim.lsp.buf.hover()<CR>
" i for implementation
map ,i :Telescope lsp_references<CR>
map ,d :Telescope lsp_definitions<CR>
map ,s :Telescope lsp_dynamic_workspace_symbols<CR>

map ,a :CodeActionMenu<CR>
map ,n :lua require('renamer').rename()<CR>

map ,/ :!g 

map ,G :GodotRunLast<CR>
map ,R :GodotRunCurrent<CR>

map ,m :Mason<CR>

map ,l :Telescope find_files<cr>
map ,g :Telescope live_grep<cr>

map ,x :BufferDelete<CR>
tnoremap ,x <C-\><C-n>:BufferDelete!<CR>
map ,r :Resurrect<CR>

noremap ,ç :BufferPrevious<CR>
tnoremap ,ç <C-\><C-n>:BufferPrevious<CR>
noremap ,à :BufferNext<CR>
tnoremap ,à <C-\><C-n>:BufferNext<CR>

noremap ,9 :BufferPrevious<CR>
tnoremap ,9 <C-\><C-n>:BufferPrevious<CR>
noremap ,0 :BufferNext<CR>
tnoremap ,0 <C-\><C-n>:BufferNext<CR>

" move to the left the current buffer in the top line bar
nnoremap ,< <Cmd>BufferMovePrevious<CR>
nnoremap ,> <Cmd>BufferMoveNext<CR><CR>

nmap ,vc :next ~/.config/nvim/init.lua<CR>
nmap ,vp :next ~/.config/nvim/lua/config/packages.lua<CR>
nmap ,vm :next ~/.config/nvim/lua/config/mappings.vim<CR>
nmap ,vr :next ~/.config/nvim/lua/config/packages-preferences.lua<CR><CR>

nmap ,V :source $MYVIMRC <CR>
" inoremap jk <esc>
" tnoremap jk <C-\><C-n><CR>

map ,u :UndotreeToggle<CR>

"  b fo bugs
map ,b :TroubleToggle<CR>

map ,c <plug>NERDCommenterToggle
imap ,c <plug>NERDCommenterInsert

map ,o :Vista!!<CR>

noremap <silent>,kr :AsyncTask file-run<cr>
noremap <silent>,kb :AsyncTask file-build<cr>
noremap <silent>,kc <C-w>o

map <silent>,kf :lua require("neotest").run.run()<cr>
map <silent>,kt :lua require("neotest").run.run(vim.fn.expand("%"))<cr>

vmap e :<C-U>!wslview "http://www.google.fr/search?hl=fr&q=<cword>" & <CR><CR>

map ,wa :lua require("harpoon.mark").add_file()<cr>
map ,wl :Telescope harpoon marks<cr>

imap <C-c> <Cmd>call codeium#Complete()<CR>
imap <script><silent><nowait><expr> <C-g> codeium#Accept()
imap <C-x>   <Cmd>call codeium#Clear()<CR>
imap <C-h>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-l>   <Cmd>call codeium#CycleCompletions(1)<CR>

tnoremap <Esc> <C-\><C-n><CR>

" select recently paste content
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Custom env variable
if !empty($KEYBOARD_FR)
  nnoremap à 0
  nnoremap & 1
  nnoremap é 2
  nnoremap " 3
  nnoremap ' 4
  nnoremap ( 5
  nnoremap - 6
  nnoremap è 7
  nnoremap _ 8
  nnoremap ç 9

  nnoremap ù `
endif

nnoremap ,1 <Cmd>BufferGoto 1<CR>
nnoremap ,& <Cmd>BufferGoto 1<CR>
nnoremap ,2 <Cmd>BufferGoto 2<CR>
nnoremap ,é <Cmd>BufferGoto 2<CR>
nnoremap ,3 <Cmd>BufferGoto 3<CR>
nnoremap ," <Cmd>BufferGoto 3<CR>
nnoremap ,4 <Cmd>BufferGoto 4<CR>
nnoremap ,' <Cmd>BufferGoto 4<CR>
nnoremap ,5 <Cmd>BufferGoto 5<CR>
nnoremap ,( <Cmd>BufferGoto 5<CR>
nnoremap ,6 <Cmd>BufferGoto 6<CR>
nnoremap ,- <Cmd>BufferGoto 6<CR>
nnoremap ,7 <Cmd>BufferGoto 7<CR>
nnoremap ,è <Cmd>BufferGoto 7<CR>
nnoremap ,8 <Cmd>BufferGoto 8<CR>
nnoremap ,_ <Cmd>BufferGoto 8<CR>

" debugging
map ;b :lua require'dap'.toggle_breakpoint()<CR>
map ;c :lua require'dap'.continue()<CR>
map ;o :lua require'dap'.step_over()<CR>
map ;i :lua require'dap'.step_into()<CR>

map ;s :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)<CR>
map ;f :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)<CR>
map ;e :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').expression)<CR>
map ;t :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').threads)<CR>
map ;u :lua require('dapui').toggle()<CR>

" ------ alt instead of ctrl for moving windows
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

tnoremap <A-H> <C-\><C-N><C-w>H
tnoremap <A-J> <C-\><C-N><C-w>J
tnoremap <A-K> <C-\><C-N><C-w>k
tnoremap <A-L> <C-\><C-N><C-w>L

inoremap <A-H> <C-\><C-N><C-w>H
inoremap <A-J> <C-\><C-N><C-w>J 
inoremap <A-K> <C-\><C-N><C-w>K
inoremap <A-L> <C-\><C-N><C-w>L

nnoremap <A-H> <C-w>H
nnoremap <A-J> <C-w>J
nnoremap <A-K> <C-w>K
nnoremap <A-L> <C-w>l
" ----- end of window movement

function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=number
        let b:signcolumn_on=1
   endif
endfunction
