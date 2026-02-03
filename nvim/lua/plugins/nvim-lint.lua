return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    local is_intersec = require("config/utils").is_intersec()

    if is_intersec then
      dofile('/home/ilan/dev/nvim-tools/dotfiles/vim/lua/plugins/lint.lua')
    else
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
    end
  end,
}

