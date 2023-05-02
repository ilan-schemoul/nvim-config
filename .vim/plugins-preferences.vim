let g:auto_save_silent = 1

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

let g:rainbow_active = 1

let g:auto_save = 1

if has("nvim")
  let g:code_action_menu_show_details = v:false

  " nerdcommenter
  let NERDSpaceDelims = 1 " 1 space after comment
  let g:NERDCustomDelimiters = {
        \ 'c': { 'left': '//', 'right': '' },
  \ }

  let g:coq_settings = {
        \ 'auto_start': 'shut-up', 'keymap.pre_select': v:false
  \ }

  let g:chadtree_settings = {
        \'view': {
          \'width': 30
        \},
        \ 'keymap.copy_relname': ['<c-c>']
      \}
end 

