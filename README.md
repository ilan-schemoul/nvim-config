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
- Fix <c-p>/<c-n> to move back forth file
- Fix swap file bug lazygit
- Improve ast grep queries for wolverine
- https://github.com/stevearc/overseer.nvim
- Rename vim lsp should save files
- Yeet dotnet plugin
- Learn shortcut vim cmd mode ?
# Medium priority
- https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md Toggle obsession, markview, autopair, lsp
- Bring back obsession or similar
- Search in past logs
- Refact deeply config+nvim
- Replace api by 1password call
- Use clipboard shortcut
- https://github.com/gbprod/substitute.nvim
- https://github.com/nvim-mini/mini.operators
- https://github.com/nvim-mini/mini.ai
## Low priority
- Remainder plugin
- https://github.com/Wansmer/treesj
