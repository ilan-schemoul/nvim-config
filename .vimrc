source ~/.vim/packages.vim

if has("nvim")
  lua require('impatient')
endif

source ~/.vim/basic.vim
source ~/.vim/vim-preferences.vim
source ~/.vim/packages-preferences.vim
source ~/.vim/mappings.vim
source ~/.vim/project-specific.vim
" nvim files
" ~/.config/nvim/init.vim
  " ~/.vim/lua/nvim-preferences.lua
  " ~/.vim/lua/nvim-packages-preferences.lua
  " ~/.vim/lua/debuggers-configuration.lua
