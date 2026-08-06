 neovim config.

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

## Highest
- Make /commit ask EXPLICIT approval of commit msg
- Improve lnav (go to exception)
- Improve ast grep queries for wolverine

## High priority
- When a test succeeds, "snapshot" of current code so if test fails after I can diff with current code
- Replace api by 1password call
- https://github.com/nvim-mini/mini.ai
- mini operators
- Use clipboard shortcut
- Alert hot mac

# Medium priority
- https://github.com/stevearc/overseer.nvim compile, rebuild, start unit/functional/integration test
- Bring back obsession or similar
- Search in past logs
## Low priority
- Remainder plugin
- https://github.com/Wansmer/treesj

# Claude skills ideas
## To commit
- Commit (optimise first speed)
- Push (optimise speed)
## To write
- Review MPEG
- Apply comments from Gitlab
- Wolverine (cascading message)
- Fix tests
- Blame (read commit, MPEG, jira ticket)
