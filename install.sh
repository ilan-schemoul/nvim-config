#!/bin/bash

mkdir -p .config/nvim

ln -s $PWD/nvim "$HOME/.config/nvim"

nvim +COQdeps
