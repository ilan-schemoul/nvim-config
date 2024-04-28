return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("telescope").load_extension("fzf")

    local actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")

    require("telescope").setup({
      pickers = {},
      defaults = {
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

    vim.api.nvim_create_user_command("CustomTelescopeSpellSuggest", function()
      require("telescope.builtin").spell_suggest({
        attach_mappings = function(prompt_bufnr)
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
  end,
}
