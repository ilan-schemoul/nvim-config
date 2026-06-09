return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    require("lint").linters_by_ft = {
      json = { "jsonlint" },
      bash = { "shellcheck" },
      shell = { "shellcheck" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}

