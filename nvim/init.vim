set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set undodir=~/.nvim/undo-dir

" disable netrw at the very start of your init.lua (strongly advised)
" https://github.com/nvim-tree/nvim-tree.lua
" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1

" ~/.vim/lua/project-pre.lua
lua require('personal-pre')

" ~/.vim/lua/nvim-preferences.lua
lua require('nvim-preferences')
" ~/.vim/lua/nvim-packages-preferences.lua
lua require('nvim-packages-preferences')
" ~/.vim/lua/debuggers-configuration.lua
lua require('debuggers-configuration')

" ~/.vim/lua/project-post.lua
lua require('personal-post')
