if $IS_ARISTA == "1"
  set tabstop=3
  set softtabstop=3
  set shiftwidth=3
  set expandtab

  set colorcolumn=85

  au! BufNewFile,BufRead *.tin setf tin
  autocmd FileType tin setlocal commentstring="// %s"
endif
