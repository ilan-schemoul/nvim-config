if !has('nvim')
  " https://github.com/ghifarit53/tokyonight-vim
  let g:tokyonight_style = 'night'
  colorscheme tokyonight
endif

let g:auto_save_silent = 1

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

let g:rainbow_active = 1

let g:auto_save = 1

let g:vista_default_executive = 'nvim_lsp'

let g:asyncrun_open = 6
