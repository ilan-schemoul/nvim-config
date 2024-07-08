return {
  "mfussenegger/nvim-lint",
  priority = 0,
  dependencies = {
    "frostplexx/mason-bridge.nvim",
  },
  opts = {},
  config = function()
    local timer = vim.uv.new_timer()
    -- I don't now why but it works
    timer:start(0, 0, vim.schedule_wrap(function()
      require("lint").linters_by_ft = require("mason-bridge").get_linters()
      require("lint").linters_by_ft.python = { "pylint" }
    end))
    -- require("lint").linters_by_ft = {
    --   python = { "pylint" },
    -- }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}

