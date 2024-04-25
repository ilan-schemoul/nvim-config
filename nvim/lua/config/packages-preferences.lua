vim.g.resurrect_ignore_patterns = { "/.git/", "^fugitive://" }
vim.g.code_action_menu_show_details = false
vim.g.vista_default_executive = "nvim_lsp"

vim.g.chadtree_settings = {
  view = {
    width = 30,
  },
  keymap = { copy_relname = { "<c-c>" } },
}

require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
require("nvim-dap-virtual-text").setup()
require("trouble").setup({})
require("fidget").setup({ progress = {
  display = { render_limit = 1 },
} })

require("colorizer").setup()

vim.api.nvim_create_user_command("CustomTelescopeSpellSuggest", function()
  require("telescope.builtin").spell_suggest({
    attach_mappings = function(prompt_bufnr)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local utils = require("telescope.utils")

      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        if selection == nil then
          utils.__warn_no_selection("builtin.spell_suggest")
          return
        end

        action_state.get_current_picker(prompt_bufnr)._original_mode = "i"
        actions.close(prompt_bufnr)
        vim.cmd("normal! " .. selection.index .. "z=")
        vim.cmd("stopinsert")
      end)
      return true
    end,
  })
end, {})

local lga_actions = require("telescope-live-grep-args.actions")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
vim.api.nvim_create_user_command("Cl", function()
  local locations = vim.fn.getqflist({ nr = "$", items = true }).items
  locations = vim.tbl_filter(function(value)
    return value.valid == 1 and value.lnum > 0
  end, locations)

  require("telescope.builtin").quickfix({
    finder = finders.new_table({
      results = locations,
      entry_maker = make_entry.gen_from_quickfix(),
    }),
  })
end, {})

require("telescope").load_extension("fzf")
require("telescope").setup({
  pickers = {},
  defaults = {
    -- file_ignore_patterns = {"eric", "elie", "camel", "muyao", "yannick", "yossef"},
    mappings = {
      i = {
        ["<C-b>"] = "file_vsplit",
      },
    },
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        width = 0.85,
      },
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          ["<C-space>"] = actions.to_fuzzy_refine,
        },
      },
    },
  },
})

require("dapui").setup({
  controls = {
    enabled = false,
  },
})

vim.g.code_action_menu_window_border = "single"

require("renamer").setup()

require("better_escape").setup()

require("telescope").load_extension("harpoon")
