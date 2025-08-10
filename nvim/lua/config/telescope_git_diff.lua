local function git_modified_files()
  local gitsigns = require("gitsigns")
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local modified_files = gitsigns.get_hunks() -- Fetch hunks (changes) tracked by Git
  local file_list = {}

  if modified_files == nil then
    return
  end

  -- Collect modified file paths
  for _, file in pairs(modified_files) do
    for _, line in pairs(file.lines) do
      local number = file.added.start
      table.insert(file_list, { line = line, number = number })
    end
  end

  -- Use Telescope to display the modified files
  require("telescope.pickers")
  .new({}, {
    prompt_title = "Git Modified Files",
    finder = require("telescope.finders").new_table({
      results = file_list,
      entry_maker = function(entry)
        return {
          display = entry.line,
          ordinal = entry.line,
          value = entry.line,
          lnum = entry.number,
        }
      end,
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    previewer = require("telescope.previewers").vim_buffer_cat.new({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        vim.cmd(tostring(entry.lnum))
      end)
      return true
    end,
  })
  :find()
end

return git_modified_files
