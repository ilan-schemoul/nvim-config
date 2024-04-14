for name, url in pairs {
  "https://github.com/folke/noice.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
} do
  local install_path = vim.fn.fnamemodify('nvim_issue/' .. name, ':p')
  if vim.fn.isdirectory(install_path) == 0 then
    vim.fn.system { 'git', 'clone', '--depth=1', url, install_path }
  end
  vim.opt.runtimepath:append(install_path)
end

require("noice").setup()
vim.cmd("set cmdheight=0")
vim.cmd('echohl WarningMsg | echo "The nvim git repository (~/nvim.ilanschemoul.me) is out of sync (must commit/push or pull)" | echohl None')
require("telescope").load_extension("noice")
