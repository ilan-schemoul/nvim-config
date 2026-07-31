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
- Add shortcut to access claude artificats
- Update commit's author all config
- Add more claude prompts
- Improve ast grep queries for wolverine
- https://github.com/stevearc/overseer.nvim compile, rebuild, aspire run, start unit/functional/integration test
- Rename vim lsp should save files
- Bring back obsession or similar
- https://github.com/gbprod/substitute.nvim
# Medium priority
- Search in past logs
- Refact deeply config+nvim
- Replace api by 1password call
- Use clipboard shortcut
- https://github.com/nvim-mini/mini.operators
- https://github.com/nvim-mini/mini.ai
## Low priority
- Remainder plugin
- https://github.com/Wansmer/treesj
