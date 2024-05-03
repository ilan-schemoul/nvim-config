lua << EOF
  function _G.CloseBuffer()
    if vim.startswith(vim.fn.expand("%"), "term://") then
      -- Closing buffer without closing window
      vim.cmd("bp|sp|bn|bd!")
    else
      -- Closing buffer without closing window
      vim.cmd("bp|sp|bn|bd")
    end
  end

  function _G.CloseWindowIfNotLast()
    local windows_in_tab = vim.tbl_filter(function(win)
      buf = vim.api.nvim_win_get_buf(win)
      name = vim.api.nvim_buf_get_name(buf)
      return vim.api.nvim_win_is_valid(win) and #name > 0
    end, vim.api.nvim_tabpage_list_wins(0))

    if #windows_in_tab <= 1 then
      print("Not closing as it's the last window")
    else
      vim.cmd("q")
    end
  end
EOF

" Useful others gF open file with line number (a.c:10)
" Mappings defined by plugins
" gA to see all bases for a number under the cursor cr{b/x/d/o} to change a
" number base

" toggle relativenumber + number. It shows on the left column the number
" of the current line and the relative number of lines aboves and below
map <silent> <leader>I :set invrelativenumber<cr>
map <silent> <leader>N :set invnumber<cr>

map <silent> <leader>E :lua require("lsp_lines").toggle()<cr>

map <silent> <leader>q :lua _G.CloseWindowIfNotLast()<cr>
tmap <silent> <LocalLeader>q <C-\><C-o>:lua _G.CloseWindowIfNotLast()<CR>
map <silent> <leader>Q :qa!<cr>
tmap <silent> <LocalLeader>Q <C-\><C-o>:qa!<cr>

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

map <silent> <leader>aa :CodeActionMenu<cr>
map <silent> <leader>at :NodeAction<cr>
map <silent> <leader>n :lua require('renamer').rename()<cr>

map <silent> <leader>/ :!g

map <silent> <leader>m :Mason<cr>

map <silent> <leader>T :Telescope<cr>
map <silent> <leader>z :Telescope buffers<cr>
map <silent> <leader>l :Telescope find_files<cr>
map <silent> <leader>gg :Telescope live_grep_args<cr>
map <silent> <leader>ù :Telescope marks<cr>
map <silent> <leader>$ :Telescope oldfiles<cr>
map <silent> <leader>tr :Telescope resume<cr>
map <silent> <leader>trh :Telescope search_history<cr>

tmap <silent> <LocalLeader>T <C-\><C-n>:Telescope<cr>
tmap <silent> <LocalLeader>z <C-\><C-n>:Telescope buffers<cr>
tmap <silent> <LocalLeader>l <C-\><C-n>:Telescope find_files<cr>
tmap <silent> <LocalLeader>g <C-\><C-n>:Telescope live_grep<cr>
tmap <silent> <LocalLeader>G <C-\><C-n>:Telescope grep_string<cr>
tmap <silent> <LocalLeader>ù <C-\><C-n>:Telescope marks<cr>
tmap <silent> <LocalLeader>$ <C-\><C-n>:Telescope oldfiles<cr>
tmap <silent> <LocalLeader>tr <C-\><C-n>:Telescope resume<cr>
tmap <silent> <LocalLeader>trh :Telescope search_history<cr>

map <silent> <leader>rr :Resurrect<cr>
tmap <silent> <LocalLeader>rr <C-\><C-n>:Resurrect<cr>

" Close buffer not window
" (https://superuser.com/questions/289285/how-to-close-buffer-without-closing-the-window)
map <silent> <leader>x :lua _G.CloseBuffer()<cr>
tnoremap <silent> <LocalLeader>x <C-\><C-n>:lua _G.CloseBuffer()<cr>

nmap <silent> <leader>vc :next ~/.config/nvim/init.lua<cr>
nmap <silent> <leader>vp :next ~/.config/nvim/lua/config/packages.lua<cr>
nmap <silent> <leader>vm :next ~/.config/nvim/lua/config/mappings.vim<cr>
nmap <silent> <leader>vr :next ~/.config/nvim/lua/config/packages-preferences.lua<cr><cr>
nmap <silent> <leader>vg :Telescope live_grep_args search_dirs=~/.config/nvim<cr>
nmap <silent> <leader>vl :Telescope find_files search_dirs=~/.config/nvim<cr>

nmap <silent> <leader>V :source $MYVIMRC <cr>
inoremap <silent> jk <esc>
tnoremap <silent> jk <C-\><C-N>
tnoremap <silent> <LocalLeader>: <C-\><C-N>:

map <silent> <leader>u :Telescope undo<cr>

"  b fo bugs
map <silent> <leader>b :TroubleToggle<cr>

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
map <silent> <leader>yl :Telescope find_files search_dirs={"~/notes"} follow=true<cr>
map <silent> <leader>yg :Telescope live_grep_args search_dirs={"~/notes"u<cr>
map <silent> <leader>yn :call v:lua.create_org_file()<cr>

tmap <silent> <LocalLeader>yi <C-\><C-n>:Neorg index<cr>
tmap <silent> <LocalLeader>yr <C-\><C-n>:Neorg return<cr>
tmap <silent> <LocalLeader>ym <C-\><C-n>:e ~/notes/memory.norg<cr>Ga
tmap <silent> <LocalLeader>yM <C-\><C-n>:botright 30vnew ~/notes/memory.norg<cr>:set invrelativenumber<cr>:set invnumber<cr>GA
tmap <silent> <LocalLeader>yl <C-\><C-n>:Telescope find_files search_dirs={"~/notes"} follow=true<cr>
tmap <silent> <LocalLeader>yg <C-\><C-n>:Telescope live_grep search_dirs={"~/notes"} follow=true<cr>
tmap <silent> <LocalLeader>yn <C-\><C-n>:call v:lua.create_org_file()<cr>

noremap <silent> zc 1z=
map <silent> z= :CustomTelescopeSpellSuggest<cr>
map <silent> zl :CustomTelescopeSpellSuggest<cr>
map <silent> zr :spellr<cr>

map <leader>pn :term<cr>
map <leader>ph :vsplit \| term<cr>
map <leader>pj :belowright split \| term<cr>
map <leader>pk :topleft split \| term<cr>
map <leader>pl :botright vs \| term<cr>

map <Leader>gl :G log<cr>
map <Leader>gp :G push<cr>
map <Leader>gu :G pull<cr>
map <Leader>go :G<cr>

map <silent> <leader>pp :put<cr>
map <silent> <leader>pP :put!<cr>

command TeeSave :w !sudo tee %

" Custom env variable
if !empty($KEYBOARD_FR)
  noremap <silent> à 0
  noremap <silent> & 1
  noremap <silent> é 2
  noremap <silent> " 3
  noremap <silent> ' 4
  noremap <silent> ( 5
  noremap <silent> - 6
  noremap <silent> è 7
  noremap <silent> _ 8
  noremap <silent> ç 9

  noremap <silent> 0 à
  noremap <silent> 1 &
  noremap <silent> 2 é
  noremap <silent> 3 "
  noremap <silent> 4 '
  noremap <silent> 5 (
  noremap <silent> 6 -
  noremap <silent> 7 è
  noremap <silent> 8 _
  noremap <silent> 9 ç

  nmap <silent> ù `
  noremap <C--> <C-^>
  tmap <C-^> <C-\><C-N><C-^>
endif

tmap <C-^> <C-\><C-N><C-^>

inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>

" map <space> ciw
" map <C-space> ciW

map <leader>t& :tabn 1<cr>
map <leader>té :tabn 2<cr>
map <leader>t" :tabn 3<cr>
map <leader>t' :tabn 4<cr>
map <leader>t( :tabn 5<cr>
map <leader>t- :tabn 6<cr>
map <leader>tè :tabn 7<cr>

map <leader>t1 :tabn 1<cr>
map <leader>t2 :tabn 2<cr>
map <leader>t3 :tabn 3<cr>
map <leader>t4 :tabn 4<cr>
map <leader>t5 :tabn 5<cr>
map <leader>t6 :tabn 6<cr>
map <leader>t7 :tabn 7<cr>

map <Leader>tn :tabnew<cr>
map <Leader>tx :tabclose<cr>
map <Leader>tl :tabnext<cr>
map <Leader>th :tabprevious<cr>
map <Leader>tL :+tabmove<cr>
map <Leader>tH :-tabmove<cr>

tmap <LocalLeader>t& <C-\><C-n>:tabn 1<cr>
tmap <LocalLeader>té <C-\><C-n>:tabn 2<cr>
tmap <LocalLeader>t" <C-\><C-n>:tabn 3<cr>
tmap <LocalLeader>t' <C-\><C-n>:tabn 4<cr>
tmap <LocalLeader>t( <C-\><C-n>:tabn 5<cr>
tmap <LocalLeader>t- <C-\><C-n>:tabn 6<cr>
tmap <LocalLeader>tè <C-\><C-n>:tabn 7<cr>

tmap <LocalLeader>t1 <C-\><C-n>:tabn 1<cr>
tmap <LocalLeader>t2 <C-\><C-n>:tabn 2<cr>
tmap <LocalLeader>t3 <C-\><C-n>:tabn 3<cr>
tmap <LocalLeader>t4 <C-\><C-n>:tabn 4<cr>
tmap <LocalLeader>t5 <C-\><C-n>:tabn 5<cr>
tmap <LocalLeader>t6 <C-\><C-n>:tabn 6<cr>
tmap <LocalLeader>t7 <C-\><C-n>:tabn 7<cr>

tmap <LocalLeader>tn <C-\><C-n>:tabnew<cr>
tmap <LocalLeader>tx <C-\><C-n>:tabclose<cr>
tmap <LocalLeader>tl <C-\><C-n>:tabnext<cr>
tmap <LocalLeader>th <C-\><C-n>:tabprevious<cr>
tmap <LocalLeader>tL <C-\><C-n>:+tabmove<cr>
tmap <LocalLeader>tH <C-\><C-n>:-tabmove<cr>

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
