 neovim config.

Install.sh creates symbolic links to this folder.

For wsl markdownPreview support : `sudo apt-get install -y xdg-utils`

`git config core.hooksPath hooks/`

# Tips
https://thevaluable.dev/vim-advanced/
Read user manual
Telescope bcommits bcommits_range

# Performance debug
  - For startup time `Lazy profile` (not perfect but good enough)
  - For runtime:
    - [plenary.profile](https://github.com/nvim-lua/plenary.nvim?tab=readme-ov-file) (wrapper around lua profiler)
    - profile.nvim (self described pile of hack)
    - perfanno to open the resulting trace file

# TODO
## High priority
- Library system in claude code with auto-open auto-send etc.
- Improve ast grep queries for wolverine
- Bring back obsession or similar
- https://github.com/stevearc/overseer.nvim
- https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md Toggle obsession, markview, autopair, lsp
- Rename vim lsp should save files
- Yeet dotnet plugin
## Low priority
- Search in past logs
- Learn shortcut vim cmd mode ?
- Refact deeply config+nvim
- Shortcut to open chrome/kitty
- Replace api by 1password call
- Remainder plugin
- Use clipboard shortcut
- https://github.com/gbprod/substitute.nvim
- https://github.com/Wansmer/treesj
- https://github.com/nvim-mini/mini.operators
- https://github.com/nvim-mini/mini.ai
