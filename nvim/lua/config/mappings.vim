" Mappings defined by plugins
" gA to see all bases for a number under the cursor cr{b/x/d/o} to change a
" number base

" toggle relativenumber + number. It shows on the left column the number
" of the current line and the relative number of lines aboves and below
map <silent> <leader>I :set invrelativenumber<cr>
map <silent> <leader>N :set invnumber<cr>

map <silent> <leader>S :call ToggleSignColumn()<cr>
map <silent> <leader>E :lua require("lsp_lines").toggle()<cr>

" closes everything
map <silent> <leader>q :q<cr>
map <silent> <leader>Q :wqa!<cr>

map <silent> <leader>D :lua vim.diagnostic.open_float()<cr>
map <silent> <leader>h :lua vim.lsp.buf.hover()<cr>
map <silent> [d :lua vim.diagnostic.goto_prev()<cr>
map <silent> ]d :lua vim.diagnostic.goto_next()<cr>
" i for implementation
map <silent> <leader>i :Telescope lsp_references<cr>
map <silent> <leader>d :Telescope lsp_definitions<cr>
map <silent> <leader>sd :Telescope lsp_dynamic_workspace_symbols<cr>
map <silent> <leader>ss :Telescope lsp_workspace_symbols<cr>
imap <silent> <C-s> <C-\><C-O>:lua vim.lsp.buf.signature_help()<cr>

map <silent> <leader>a :CodeActionMenu<cr>
map <silent> <leader>n :lua require('renamer').rename()<cr>

map <silent> <leader>/ :!g

" map <silent> <leader>G :GodotRunLast<cr>
" map <silent> <leader>R :GodotRunCurrent<cr>

map <silent> <leader>m :Mason<cr>

map <silent> <leader>T :Telescope<cr>
map <silent> <leader>z :Telescope buffers<cr>
map <silent> <leader>l :Telescope find_files<cr>
map <silent> <leader>g :Telescope live_grep<cr>
map <silent> <leader>G :Telescope grep_string<cr>
map <silent> <leader>ù :Telescope marks<cr>
map <silent> <leader>$ :Telescope oldfiles<cr>

map <silent> <leader>x :bd<cr>
tnoremap <silent> <leader>x <C-\><C-n>:bd!<cr>
map <silent> <leader>r :Resurrect<cr>

noremap <silent> <leader>ç :bp<cr>
tnoremap <silent> <leader>ç <C-\><C-n>:bp<cr>
noremap <silent> <leader>à :bn<cr>
tnoremap <silent> <leader>à <C-\><C-n>:bn<cr>

noremap <silent> <leader>9 :bp<cr>
tnoremap <silent> <leader>9 <C-\><C-n>:bp<cr>
noremap <silent> <leader>0 :bn<cr>
tnoremap <silent> <leader>0 <C-\><C-n>:bn<cr>

nmap <silent> <leader>vc :next ~/.config/nvim/init.lua<cr>
nmap <silent> <leader>vp :next ~/.config/nvim/lua/config/packages.lua<cr>
nmap <silent> <leader>vm :next ~/.config/nvim/lua/config/mappings.vim<cr>
nmap <silent> <leader>vr :next ~/.config/nvim/lua/config/packages-preferences.lua<cr><cr>
nmap <silent> <leader>vg :Telescope live_grep search_dirs=~/nvim.ilanschemoul.me/nvim<cr>
nmap <silent> <leader>vl :Telescope find_files search_dirs=~/nvim.ilanschemoul.me/nvim<cr>

nmap <silent> <leader>V :source $MYVIMRC <cr>
" inoremap <silent> jk <esc>
" tnoremap <silent> jk <C-\><C-n><cr>

map <silent> <leader>u :UndotreeToggle<cr>

"  b fo bugs
map <silent> <leader>b :TroubleToggle<cr>

map <silent> <leader>o :Vista!!<cr>

map <silent> <leader>wa :lua require("harpoon.mark").add_file()<cr>
map <silent> <leader>wl :Telescope harpoon marks<cr>
map <silent> <leader>w& :lua require("harpoon.ui").nav_file(1)<cr>
map <silent> <leader>w1 :lua require("harpoon.ui").nav_file(1)<cr>
map <silent> <leader>wé :lua require("harpoon.ui").nav_file(2)<cr>
map <silent> <leader>w2 :lua require("harpoon.ui").nav_file(2)<cr>
map <silent> <leader>w" :lua require("harpoon.ui").nav_file(3)<cr>
map <silent> <leader>w3 :lua require("harpoon.ui").nav_file(3)<cr>
map <silent> <leader>w' :lua require("harpoon.ui").nav_file(4)<cr>
map <silent> <leader>w4 :lua require("harpoon.ui").nav_file(4)<cr>
map <silent> <leader>w( :lua require("harpoon.ui").nav_file(5)<cr>
map <silent> <leader>w5 :lua require("harpoon.ui").nav_file(5)<cr>
map <silent> <leader>w- :lua require("harpoon.ui").nav_file(6)<cr>
map <silent> <leader>w6 :lua require("harpoon.ui").nav_file(6)<cr>

lua << EOF
function _G.create_org_file()
  local dirman = require('neorg').modules.get_module("core.dirman")
  local file = vim.fn.input("File : ", "", "file")

  dirman.create_file(file, "notes", {
      no_open  = false, -- open file after creation?
      force    = false, -- overwrite file if exists
  })
end
EOF

map <silent> <leader>yi :Neorg index<cr>
map <silent> <leader>yr :Neorg return<cr>
map <silent> <leader>ym :e ~/notes/memory.norg<cr>Ga
map <silent> <leader>yM :botright 30vnew ~/notes/memory.norg<cr>:set invrelativenumber<cr>:set invnumber<cr>GA
" :set invrelativenumber<cr> :set invnumber<cr>
map <silent> <leader>yl :Telescope find_files search_dirs={"~/notes"}<cr>
map <silent> <leader>yg :Telescope live_grep search_dirs={"~/notes"}<cr>
map <silent> <leader>yn :call v:lua.create_org_file()<cr>

noremap <silent> zc 1z=
map <silent> z= :CustomTelescopeSpellSuggest<cr>
map <silent> zl :CustomTelescopeSpellSuggest<cr>
map <silent> zr :spellr<cr>

nmap <silent> <leader>? <Plug>SearchNormal
vmap <silent> <leader>? <Plug>SearchVisual

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

nnoremap <silent> <leader>1 <Cmd>BufferGoto 1<cr>
nnoremap <silent> <leader>& <Cmd>BufferGoto 1<cr>
nnoremap <silent> <leader>2 <Cmd>BufferGoto 2<cr>
nnoremap <silent> <leader>é <Cmd>BufferGoto 2<cr>
nnoremap <silent> <leader>3 <Cmd>BufferGoto 3<cr>
nnoremap <silent> <leader>" <Cmd>BufferGoto 3<cr>
nnoremap <silent> <leader>4 <Cmd>BufferGoto 4<cr>
nnoremap <silent> <leader>' <Cmd>BufferGoto 4<cr>
nnoremap <silent> <leader>5 <Cmd>BufferGoto 5<cr>
nnoremap <silent> <leader>( <Cmd>BufferGoto 5<cr>
nnoremap <silent> <leader>6 <Cmd>BufferGoto 6<cr>
nnoremap <silent> <leader>- <Cmd>BufferGoto 6<cr>
nnoremap <silent> <leader>7 <Cmd>BufferGoto 7<cr>
nnoremap <silent> <leader>è <Cmd>BufferGoto 7<cr>
nnoremap <silent> <leader>8 <Cmd>BufferGoto 8<cr>
nnoremap <silent> <leader>_ <Cmd>BufferGoto 8<cr>

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
