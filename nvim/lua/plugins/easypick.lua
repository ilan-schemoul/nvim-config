
return {
  "axkirillov/easypick.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local easypick = require("easypick")

    easypick.setup({
      pickers = {
        -- diff current branch with base_branch and show files that changed with respective diffs in preview
        {
          name = "changed_files",
          command = "git diff --name-only",
          previewer = easypick.previewers.file_diff()
        },

        -- list files that have conflicts with diffs in preview
        {
          name = "conflicts",
          command = "git diff --name-only --diff-filter=U --relative",
          previewer = easypick.previewers.file_diff()
        },
      }
    })
  end
}

