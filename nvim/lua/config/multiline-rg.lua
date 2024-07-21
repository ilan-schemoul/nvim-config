local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local utils = require "telescope.utils"
local make_entry = require "telescope.make_entry"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"

local M = {}

M.open = function(opts)
  opts = opts or {}

  local live_grepper = finders.new_job(function(prompt)
    opts.cwd = opts.cwd and utils.path_expand(opts.cwd) or vim.loop.cwd()
    local args = opts.vimgrep_arguments or conf.vimgrep_arguments

    if not prompt or prompt == "" then
      return nil
    end

    return utils.flatten { args, "--multiline", "--", prompt, opts.cwd }
  end, opts.entry_maker or make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)

  pickers
    .new(opts, {
      prompt_title = "Multiline grep",
      finder = live_grepper,
      previewer = conf.grep_previewer(opts),
      sorter = sorters.highlighter_only(opts),
      default_text = "(.*\\n){0,1}.*",
      attach_mappings = function(_, map)
        map("i", "<c-space>", actions.to_fuzzy_refine)
        return true
      end,
      push_cursor_on_edit = true,
    })
    :find()
end

return M
