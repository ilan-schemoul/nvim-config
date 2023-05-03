My config compatible with both vim and neovim.
- LSP supports
- Around 40-50 packages
- Developped over the years
- A mix of lua and vimscript (because vimscript is more handy for a lot of things including mapping and sometimes lua is necessary)
- Quite documented
My config is public to make it easier for me to install and share it.

Install.sh creates symbolic links to this folder and install Plug ((n)vim package manager) and install all packages.

You can use my config straight away but it's probably better to make your own config (and take a look at mine if it's any useful).
# Todo
- Add COQdeps
- Quit vim and nvim after install
- Option to only install nvim or vim
- Editor command to synchronise config
- Notification when out of sync with upstream
