#!/bin/bash

DIR=$(basename "$PWD")

mkdir -p .config/nvim

ln -s $PWD/.{vim,vimrc} "$HOME"
ln -s $PWD/nvim "$HOME/.config/nvim"

if command -v vim &> /dev/null
then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall
fi

if command -v nvim &> /dev/null
then
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  nvim +PlugInstall +COQdeps
  # For wsl markdownPreview support
  # sudo apt-get install -y xdg-utils
fi


