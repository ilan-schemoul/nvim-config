return {
  "nvim-telescope/telescope.nvim",
  cmd = {
    "Telescope",
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "debugloop/telescope-undo.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  config = function()
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("undo")

    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local lga_actions = require("telescope-live-grep-args.actions")

    require("telescope").setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          -- NOTE: this is what I added compared to Telescope defaults
          "--multiline",
        },
        mappings = {
          i = {
            ["<C-v>"] = "file_vsplit",
            ["<C-s>"] = "file_split",
            ["<C-x>"] = actions.delete_buffer,
            -- NOTE: this a extremely useful thing I made to search over
            -- multiples lines. If you wanna search where in the code you can
            -- find ABC and then a few lines after (10 maximum) XYZ:
            -- Type ABC then <C-i> then type 10 then <C-i> then tpye ABC.
            ["<C-i>"] = function(bufnr)
              local picker = action_state.get_current_picker(bufnr)
              local prompt = picker:_get_prompt()

              if prompt:match("\\n") then
                picker:set_prompt("}.*", false)
              else
                picker:set_prompt("(.*\\n){0,", false)
              end
            end,
            ["<S-Down>"] = require('telescope.actions').cycle_history_next,
            ["<S-Up>"] = require('telescope.actions').cycle_history_prev,
          },
        },
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            width = 0.85,
          },
        },
        preview = {
          filetype_hook = function(filepath, bufnr, opts)
            local putils = require("telescope.previewers.utils")
            local skip = opts.ft == "norg"
            if skip then
              putils.set_preview_message(
                bufnr,
                opts.winid,
                string.format("Cannot preview neorg files (it's a workaround)")
              )
            end

            return not skip
          end,
        }
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
