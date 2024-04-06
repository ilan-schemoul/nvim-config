" Mappings defined by plugins
" gA to see all bases for a number under the cursor cr{b/x/d/o} to change a
" number base

" toggle relativenumber + number. It shows on the left column the number
" of the current line and the relative number of lines aboves and below
map <silent> ,I :set invrelativenumber<cr>
map <silent> ,N :set invnumber<cr>

map <silent> ,S :call ToggleSignColumn()<cr>
map <silent> ,E :lua require("lsp_lines").toggle()<cr>

" closes everything
map <silent> ,q :q<cr>
map <silent> ,Q :wqa!<cr>

" toggle the tree files on the left
map <silent> ,t :NvimTreeToggle<cr>

map <silent> ,D :lua vim.diagnostic.open_float()<cr>
map <silent> ,h :lua vim.lsp.buf.hover()<cr>
map <silent> [d :lua vim.diagnostic.goto_prev()<cr>
map <silent> ]d :lua vim.diagnostic.goto_next()<cr>
" i for implementation
map <silent> ,i :Telescope lsp_references<cr>
map <silent> ,d :Telescope lsp_definitions<cr>
map <silent> ,sd :Telescope lsp_dynamic_workspace_symbols<cr>
map <silent> ,ss :Telescope lsp_workspace_symbols<cr>
imap <silent> <C-s> <C-\><C-O>:lua vim.lsp.buf.signature_help()<cr>

map <silent> ,a :CodeActionMenu<cr>
map <silent> ,n :lua require('renamer').rename()<cr>

map <silent> ,/ :!g 

" map <silent> ,G :GodotRunLast<cr>
" map <silent> ,R :GodotRunCurrent<cr>

map <silent> ,m :Mason<cr>

map <silent> ,T :Telescope<cr>
map <silent> ,z :Telescope buffers<cr>
map <silent> ,l :Telescope find_files<cr>
map <silent> ,g :Telescope live_grep<cr>
map <silent> ,G :Telescope grep_string<cr>
map <silent> ,ù :Telescope marks<cr>
map <silent> ,$ :Telescope oldfiles<cr>

map <silent> ,x :bd<cr>
tnoremap <silent> ,x <C-\><C-n>:bd!<cr>
map <silent> ,r :Resurrect<cr>

noremap <silent> ,ç :bp<cr>
tnoremap <silent> ,ç <C-\><C-n>:bp<cr>
noremap <silent> ,à :bn<cr>
tnoremap <silent> ,à <C-\><C-n>:bn<cr>

noremap <silent> ,9 :bp<cr>
tnoremap <silent> ,9 <C-\><C-n>:bp<cr>
noremap <silent> ,0 :bn<cr>
tnoremap <silent> ,0 <C-\><C-n>:bn<cr>

nmap <silent> ,vc :next ~/.config/nvim/init.lua<cr>
nmap <silent> ,vp :next ~/.config/nvim/lua/config/packages.lua<cr>
nmap <silent> ,vm :next ~/.config/nvim/lua/config/mappings.vim<cr>
nmap <silent> ,vr :next ~/.config/nvim/lua/config/packages-preferences.lua<cr><cr>
nmap <silent> ,vg :Telescope live_grep search_dirs=~/nvim.ilanschemoul.me/nvim<cr>
nmap <silent> ,vl :Telescope find_files search_dirs=~/nvim.ilanschemoul.me/nvim<cr>

nmap <silent> ,V :source $MYVIMRC <cr>
" inoremap <silent> jk <esc>
" tnoremap <silent> jk <C-\><C-n><cr>

map <silent> ,u :UndotreeToggle<cr>

"  b fo bugs
map <silent> ,b :TroubleToggle<cr>

map <silent> ,o :Vista!!<cr>

map <silent> <silent>,kf :lua require("neotest").run.run()<cr>
map <silent> <silent>,kt :lua require("neotest").run.run(vim.fn.expand("%"))<cr>

map <silent> ,wa :lua require("harpoon.mark").add_file()<cr>
map <silent> ,wl :Telescope harpoon marks<cr>
map <silent> ,w& :lua require("harpoon.ui").nav_file(1)<cr>
map <silent> ,w1 :lua require("harpoon.ui").nav_file(1)<cr>
map <silent> ,wé :lua require("harpoon.ui").nav_file(2)<cr>
map <silent> ,w2 :lua require("harpoon.ui").nav_file(2)<cr>
map <silent> ,w" :lua require("harpoon.ui").nav_file(3)<cr>
map <silent> ,w3 :lua require("harpoon.ui").nav_file(3)<cr>
map <silent> ,w' :lua require("harpoon.ui").nav_file(4)<cr>
map <silent> ,w4 :lua require("harpoon.ui").nav_file(4)<cr>
map <silent> ,w( :lua require("harpoon.ui").nav_file(5)<cr>
map <silent> ,w5 :lua require("harpoon.ui").nav_file(5)<cr>
map <silent> ,w- :lua require("harpoon.ui").nav_file(6)<cr>
map <silent> ,w6 :lua require("harpoon.ui").nav_file(6)<cr>

lua << EOF
function _G.create_org_file()
  local dirman = require('neorg').modules.get_module("core.dirman")
  local file = vim.fn.input("File : ", "", "file")

  dirman.create_file(file, "notes", {
      no_open  = false,  -- open file after creation?
      force    = false,  -- overwrite file if exists
  })
end
EOF

map <silent> ,yi :Neorg index<cr>
map <silent> ,yr :Neorg return<cr>
map <silent> ,ym :e ~/notes/memory.norg<cr>Ga
map <silent> ,yM :botright 30vnew ~/notes/memory.norg<cr>:set invrelativenumber<cr>:set invnumber<cr>GA
" :set invrelativenumber<cr> :set invnumber<cr>
map <silent> ,yl :Telescope find_files search_dirs={"~/notes"}<cr>
map <silent> ,yg :Telescope live_grep search_dirs={"~/notes"}<cr>
map <silent> ,yn :call v:lua.create_org_file()<cr>

noremap <silent> zc 1z=
map <silent> z= :CustomTelescopeSpellSuggest<cr>
map <silent> zl :CustomTelescopeSpellSuggest<cr>
map <silent> zr :spellr<cr>

nmap <silent> <Leader>? <Plug>SearchNormal
vmap <silent> <Leader>? <Plug>SearchVisual

tnoremap <silent> <Esc> <C-\><C-n><cr>

" select recently paste content
nnoremap <silent> <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Custom env variable
if !empty($KEYBOARD_FR)
  map <silent> à 0
  map <silent> & 1
  map <silent> é 2
  map <silent> " 3
  map <silent> ' 4
  map <silent> ( 5
  map <silent> - 6
  map <silent> è 7
  map <silent> _ 8
  map <silent> ç 9

  nmap <silent> ù `
endif

nnoremap <silent> ,1 <Cmd>BufferGoto 1<cr>
nnoremap <silent> ,& <Cmd>BufferGoto 1<cr>
nnoremap <silent> ,2 <Cmd>BufferGoto 2<cr>
nnoremap <silent> ,é <Cmd>BufferGoto 2<cr>
nnoremap <silent> ,3 <Cmd>BufferGoto 3<cr>
nnoremap <silent> ," <Cmd>BufferGoto 3<cr>
nnoremap <silent> ,4 <Cmd>BufferGoto 4<cr>
nnoremap <silent> ,' <Cmd>BufferGoto 4<cr>
nnoremap <silent> ,5 <Cmd>BufferGoto 5<cr>
nnoremap <silent> ,( <Cmd>BufferGoto 5<cr>
nnoremap <silent> ,6 <Cmd>BufferGoto 6<cr>
nnoremap <silent> ,- <Cmd>BufferGoto 6<cr>
nnoremap <silent> ,7 <Cmd>BufferGoto 7<cr>
nnoremap <silent> ,è <Cmd>BufferGoto 7<cr>
nnoremap <silent> ,8 <Cmd>BufferGoto 8<cr>
nnoremap <silent> ,_ <Cmd>BufferGoto 8<cr>

autocmd FileType norg let b:norg = v:true

if !exists("b:norg")
    " debugging
    map <silent> ;b :lua require'dap'.toggle_breakpoint()<cr>
    map <silent> ;c :lua require'dap'.continue()<cr>
    map <silent> ;o :lua require'dap'.step_over()<cr>
    map <silent> ;i :lua require'dap'.step_into()<cr>

    map <silent> ;s :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)<cr>
    map <silent> ;f :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)<cr>
    map <silent> ;e :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').expression)<cr>
    map <silent> ;t :lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').threads)<cr>
    map <silent> ;u :lua require('dapui').toggle()<cr>
    map <silent> ; ;;
endif

" ------ alt instead of ctrl for moving windows
tnoremap <silent> <A-h> <C-\><C-N><C-w>h
tnoremap <silent> <A-j> <C-\><C-N><C-w>j
tnoremap <silent> <A-k> <C-\><C-N><C-w>k
tnoremap <silent> <A-l> <C-\><C-N><C-w>l

inoremap <silent> <A-h> <C-\><C-N><C-w>h
inoremap <silent> <A-j> <C-\><C-N><C-w>j
inoremap <silent> <A-k> <C-\><C-N><C-w>k
inoremap <silent> <A-l> <C-\><C-N><C-w>l

nnoremap <silent> <A-h> <C-w>h
nnoremap <silent> <A-j> <C-w>j
nnoremap <silent> <A-k> <C-w>k
nnoremap <silent> <A-l> <C-w>l

tnoremap <silent> <A-H> <C-\><C-N><C-w>H
tnoremap <silent> <A-J> <C-\><C-N><C-w>J
tnoremap <silent> <A-K> <C-\><C-N><C-w>k
tnoremap <silent> <A-L> <C-\><C-N><C-w>L

inoremap <silent> <A-H> <C-\><C-N><C-w>H
inoremap <silent> <A-J> <C-\><C-N><C-w>J 
inoremap <silent> <A-K> <C-\><C-N><C-w>K
inoremap <silent> <A-L> <C-\><C-N><C-w>L

nnoremap <silent> <A-H> <C-w>H
nnoremap <silent> <A-J> <C-w>J
nnoremap <silent> <A-K> <C-w>K
nnoremap <silent> <A-L> <C-w>L
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
