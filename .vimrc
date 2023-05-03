source ~/.vim/personal-pre.vim
source ~/.vim/packages.vim

if has("nvim")
  lua require('impatient')
endif

source ~/.vim/basic.vim
source ~/.vim/vim-preferences.vim
source ~/.vim/packages-preferences.vim
source ~/.vim/mappings.vim
source ~/.vim/personal-post.vim
" nvim files (type gf when the cursor is on a file path to open it)
" ~/.config/nvim/init.vim
  " ~/.vim/lua/project-pre.lua
  " ~/.vim/lua/nvim-preferences.lua
  " ~/.vim/lua/nvim-packages-preferences.lua
  " ~/.vim/lua/debuggers-configuration.lua
  " ~/.vim/lua/project-post.lua
