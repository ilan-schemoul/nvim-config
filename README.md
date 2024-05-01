My neovim config.

Install.sh creates symbolic links to this folder.

For wsl markdownPreview support : `sudo apt-get install -y xdg-utils`

`git config core.hooksPath hooks/`

# Tips
https://thevaluable.dev/vim-advanced/
Read user manual
Telescope bcommits bcommits_range
# Compile
Master is relatively stable.
However the default release on git for master are in debug mode which contains an assert which fails because of Noice (if we also "echo" and have Telescope enable for some reasons).
Therefore it is better to compile in release mode.

`CC=gcc-13 make CMAKE_EXTRA_FLAGS="-DCMAKE_C_FLAGS=-fuse-ld=mold" CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=~/.bin/nvim-unstable && CC=gcc-13 make install CMAKE_EXTRA_FLAGS="-DCMAKE_C_FLAGS=-fuse-ld=mold" CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=~/.bin/nvim-unstable`
