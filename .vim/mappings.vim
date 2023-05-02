" toggle relativenumber + number. It shows on the left column the number
" of the current line and the relative number of lines aboves and below
map ,I :set invrelativenumber<CR>
map ,N :set invnumber<CR>

map ,S :call ToggleSignColumn()<CR>
map ,E :lua require("lsp_lines").toggle()<CR>
map ,e <Plug>(toggle-lsp-diag)

" multiple cursors
let g:VM_mouse_mappings = 1
nmap   <C-LeftMouse>         <Plug>(VM-Mouse-Cursor)
nmap   <C-RightMouse>        <Plug>(VM-Mouse-Word)
nmap   <M-C-RightMouse>      <Plug>(VM-Mouse-Column)

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

map ,X :SnipRun<CR>
map ,Z :SnipClose<CR>

imap <C-p> <ESC> :Copilot panel<CR>

inoremap <C-f> <Plug>(copilot-suggest)
inoremap <C-d> <Plug>(copilot-dismiss)
inoremap <M-i> <Plug>(copilot-previous)
inoremap <M-o> <Plug>(copilot-next)

map ,l :Telescope find_files<cr>
map ,g :Telescope live_grep<cr>
map ,, :Telescope<cr>

map ,x :BufferDelete<CR>
tnoremap ,x <C-\><C-n>:BufferDelete!<CR>

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

nmap ,v :next ~/.vimrc ~/.config/nvim/init.vim<CR>
nmap ,V :source $MYVIMRC <CR>
" inoremap jk <esc>
" tnoremap jk <C-\><C-n><CR>

map ,u :UndotreeToggle<CR>

"  b fo bugs
map ,b :TroubleToggle<CR>

map ,c <plug>NERDCommenterToggle
imap ,c <plug>NERDCommenterInsert

map ,? :Cheatsheet<CR>

map ,oo :!/bin/fish -i -c obsidian %<CR>
map ,ol :ObsidianQuickSwitch<CR>
map ,of :ObsidianFollowLink<CR>
map ,os :ObsidianSearch<CR>

map ,zl :PlugInstall<CR>

tnoremap <Esc> <C-\><C-n><CR>

" select recently paste content
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

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

" debugging
map <leader>b :lua require'dap'.toggle_breakpoint()<CR>
map <leader>c :lua require'dap'.continue()<CR>
map <leader>o :lua require'dap'.step_over()<CR>
map <leader>i :lua require'dap'.step_into()<CR>
map <leader>s :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)<CR>
map <leader>f :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)<CR>
map <leader>e :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').expression)<CR>
map <leader>t :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').threads)<CR>
map <leader>u :lua require('dapui').toggle()<CR>


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
