vim.g.resurrect_ignore_patterns = { "/.git/", "^fugitive://" }

vim.g.code_action_menu_show_details = false
vim.g.code_action_menu_window_border = "single"

vim.g.vista_default_executive = "nvim_lsp"

vim.g.chadtree_settings = {
    view = { width = 30,  },
    keymap = { copy_relname = { "<c-c>" } },
}

require("trouble").setup({})

require("fidget").setup({ progress = {
  display = { render_limit = 1 },
} })

require("colorizer").setup()

require("renamer").setup()

require("better_escape").setup()
