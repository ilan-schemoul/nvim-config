vim.g.VM_mouse_mappings = 1
vim.g.resurrect_ignore_patterns = { '/.git/', '^fugitive://' }
vim.g.auto_save_silent = 1
vim.g.auto_save = 1
vim.g.code_action_menu_show_details = false
vim.g.NERDSpaceDelims = 1
vim.g.NERDCustomDelimiters = {
  c = { left = '//', right = '' }
}
vim.g.vista_default_executive = 'nvim_lsp'
vim.g.asyncrun_open = 6 -- for AsyncTask

vim.g.chadtree_settings = {
  view = {
    width = 30
  },
  keymap = { copy_relname = { '<c-c>' } },
}

vim.g.codeium_manual = true

vim.g.calendar_google_calendar = 1
vim.g.calendar_google_task = 1

require("nvim-tree").setup()
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
require("nvim-dap-virtual-text").setup()
require("trouble").setup {}
require "fidget".setup { progress = {
  display = { render_limit = 1 } },
}

require 'colorizer'.setup()

require('telescope').load_extension('fzf')
require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = {
        width = 0.85
      }
    },
  },
})


require("dapui").setup({
  controls = {
    enabled = false,
  },
})

local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match("warning: multiple different client offset_encodings") then
    return
  end

  notify(msg, ...)
end

vim.g.code_action_menu_window_border = 'single'

require 'bufferline'.setup { auto_hide = true, minimum_padding = 0, maximum_padding = 0, icons = { filetype = { enabled = false }, modified = { button = false } } }

require('leap').add_default_mappings()

vim.keymap.del({ 'x', 'o' }, 'x')
vim.keymap.del({ 'x', 'o' }, 'X')

require("renamer").setup()

require("oil").setup()

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require('neotest-rust')
  },
})

require("better_escape").setup()

require("catppuccin").setup({
  integrations = {
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = true,
    mason = true,
    neotest = true,
    dap = true,
    dap_ui = true,
    rainbow_delimiters = true,
    telescope = { enabled = true },
  }
})

require("telescope").load_extension('harpoon')

-- local harpoon = require("harpoon")

-- -- REQUIRED
-- harpoon:setup({})
-- -- REQUIRED

-- vim.keymap.set("n", ",wa", function() harpoon:list():append() end)

-- vim.keymap.set("n", ",w1", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", ",w&", function() harpoon:list():select(1) end)

-- vim.keymap.set("n", ",w2", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", ",wé", function() harpoon:list():select(2) end)

-- vim.keymap.set("n", ",w3", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", ",w\"", function() harpoon:list():select(3) end)

-- vim.keymap.set("n", ",w4", function() harpoon:list():select(4) end)
-- vim.keymap.set("n", ",w'", function() harpoon:list():select(4) end)

-- -- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-N>", function() harpoon:list():next() end)

-- -- basic telescope configuration
-- local conf = require("telescope.config").values
-- local function toggle_telescope(harpoon_files)
  -- local file_paths = {}
  -- for _, item in ipairs(harpoon_files.items) do
    -- table.insert(file_paths, item.value)
  -- end

  -- require("telescope.pickers").new({}, {
    -- prompt_title = "Harpoon",
    -- finder = require("telescope.finders").new_table({
      -- results = file_paths,
    -- }),
    -- previewer = conf.file_previewer({}),
    -- sorter = conf.generic_sorter({}),
  -- }):find()
-- end

-- vim.keymap.set("n", ",wl", function() toggle_telescope(harpoon:list()) end,
  -- { desc = "Open harpoon window" })

  -- local conf = require("telescope.config").values
-- local pickers = require("telescope.pickers")
-- local themes = require("telescope.themes")
-- local finders = require("telescope.finders")
-- local actions = require("telescope.actions")
-- local action_state = require("telescope.actions.state")
-- local harpoon = require('harpoon')
-- harpoon:setup({})

