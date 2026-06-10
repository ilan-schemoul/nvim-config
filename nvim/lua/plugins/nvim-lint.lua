return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    local lint = require("lint")

    lint.linters.csharpier = {
      name = "CSharpier",
      cmd = "csharpier",
      -- `check` via stdin silently behaves like `format` (exit 0), so lint the saved file
      stdin = false,
      append_fname = true,
      args = { "check", "--no-msbuild-check" },
      stream = "stderr",
      ignore_exitcode = true, -- exits 1 when the file is unformatted
      parser = function(output)
        if not output:find("Was not formatted", 1, true) then
          return {}
        end
        local lnum = tonumber(output:match("Expected: Around Line (%d+)")) or 1
        local message = "File is not formatted"
        local expected = output:match("%-%-%-+ Expected: Around Line %d+ %-%-%-+\n(.-)\n%s*%-%-%-+ Actual:")
        if expected then
          -- csharpier indents the snippet by two spaces for display; strip it
          expected = expected:gsub("^  ", ""):gsub("\n  ", "\n"):gsub("%s+$", "")
          message = "Replace by:\n" .. expected
        end
        return {
          {
            lnum = lnum - 1,
            col = 0,
            severity = vim.diagnostic.severity.WARN,
            source = "csharpier",
            message = message,
          },
        }
      end,
    }

    lint.linters_by_ft = {
      json = { "jsonlint" },
      bash = { "shellcheck" },
      shell = { "shellcheck" },
      cs = { "csharpier" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}

