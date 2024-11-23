
return {
  "axkirillov/easypick.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local easypick = require("easypick")
    local previewers = require "telescope.previewers"
    local putils = require "telescope.previewers.utils"

    local diff_previous_commit = function ()
      return previewers.new_buffer_previewer {
        title = "Git Previous Commit Diff Preview",
        get_buffer_by_name = function(_, entry)
          return entry.value
        end,

        define_preview = function(self, entry, _)
          local file_name = entry.value
          putils.job_maker({ "git", "--no-pager", "diff", "HEAD~", "--", file_name }, self.state.bufnr, {
            value = file_name,
            bufname = self.state.bufname,
          })
          putils.regex_highlighter(self.state.bufnr, "diff")
        end,
      }
    end

    easypick.setup({
      pickers = {
        -- diff current branch with base_branch and show files that changed with respective diffs in preview
        {
          name = "changed_files",
          command = "git diff --name-only HEAD",
          previewer = easypick.previewers.file_diff()
        },
        {
          name = "new_files",
          command = "git ls-files --others --exclude-standard",
          previewer = easypick.previewers.default()
        },

        {
          name = "changed_files_previous_commit",
          command = "git diff --name-only HEAD~",
          previewer = diff_previous_commit()
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

