My neovim config.

# Install

Install.sh creates symbolic links to this folder.

For wsl markdownPreview support : `sudo apt-get install -y xdg-utils`

`git config core.hooksPath hooks/`

# Tips
https://thevaluable.dev/vim-advanced/
Telescope bcommits bcommits_range
:g/TODO/d => delete line
:g/TODO/norm A; => append A;
visual selection then type norm A, => insert , at the end
gi last insert position and go in insert mode
g; jump previous change
g, jump next change
gv last selection
`` previous position
`. last change position
`" position last file closed

# Performance debug
- For startup time `Lazy profile` (not perfect but good enough)
- For runtime:
 - [plenary.profile](https://github.com/nvim-lua/plenary.nvim?tab=readme-ov-file) (wrapper around lua profiler)
 - profile.nvim (self described pile of hack)
 - perfanno to open the resulting trace file

# TODO

- Most important is ~/code/dotfiles2/claude/TODO.MD

## Highest
- Improve ast grep queries for wolverine
- fix auto save diffbandit (add local variable buffer bandit)

## High priority
- Add force push on lazygit itself (custom command doesn't work)
- fix conflict not detect first time
- fix restart taking 10 mn randomly
- fix separators
- noice double not printed
- Replace api by 1password call
- https://github.com/nvim-mini/mini.ai
- mini operators

# Medium priority
- When a test succeeds, "snapshot" of current code so if test fails after I can diff with current code
- Bring back obsession or similar or at least shortcut to save current session

## Low priority
- Search in past logs
- https://github.com/stevearc/overseer.nvim compile, rebuild, start unit/functional/integration test
- Remainder plugin
- https://github.com/Wansmer/treesj

