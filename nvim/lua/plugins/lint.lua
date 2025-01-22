return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    require("lint").linters_by_ft = {
      json = { "jsonlint" },
      python = { "pylint" },
      bash = { "shellcheck" },
      shell = { "shellcheck" },
    }

    if require("config/utils").is_intersec then
      local pylint = require("lint").linters.pylint
      pylint.cmd = "poetry"
      pylint.args = vim.list_extend({ "run", "pylint" }, pylint.args)
    end

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}

