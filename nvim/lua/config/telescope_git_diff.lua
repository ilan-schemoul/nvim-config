local gitsigns = require("gitsigns")

local function git_modified_files()
  local modified_files = gitsigns.get_hunks() -- Fetch hunks (changes) tracked by Git
  local file_list = {}

  -- Collect modified file paths
  for _, file in pairs(modified_files) do
    for _, line in pairs(file.lines) do
      table.insert(file_list, line)
    end
  end

  -- Use Telescope to display the modified files
  require("telescope.pickers")
  .new({}, {
    prompt_title = "Git Modified Files",
    finder = require("telescope.finders").new_table({
      results = file_list,
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    previewer = require("telescope.previewers").vim_buffer_cat.new({}),
  })
  :find()
end

return git_modified_files
