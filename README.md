 neovim config.

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

# cmp vs coq
Coq faster
Cmp UI much better, compatible with non proprietary snippets (so compatible with vscode snippets etc. which also means scissors (to edit snipppets) are compatible), compatible with noice (https://github.com/folke/noice.nvim/issues/758)
kind of a shame coq is faster thanks to a ton of optimizations but close to unusable because bad UI, not compatible with snippets or Noice completion

# Performance debug
  - For startup time `Lazy profile` (not perfect but good enough)
  - For runtime:
    - [plenary.profile](https://github.com/nvim-lua/plenary.nvim?tab=readme-ov-file) (wrapper around lua profiler)
    - profile.nvim (self described pile of hack)
    - perfanno to open the resulting trace file

# Treesitter

TS is cool but kinda slow. Async can help when it will land https://github.com/neovim/neovim/pull/22420

Many plugins have poor support. Queries support for C is terrible (I added mine). Every parser
update can break query. Parser must be compiled manually (WASM support in 0.11 might fix that).

Things like textobjects, swap etc. are really cool but very slow so I can't use it at work (files over 5K lines...).

Basically a cool beta but I'll have to wait at least nvim 0.11 to have TS 1.0 support https://github.com/neovim/neovim/issues/22313
before it's usable.
