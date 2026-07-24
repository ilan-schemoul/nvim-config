return {
  "folke/trouble.nvim",
  event = "NormalBufferEnter",
  opts = {
    modes = {
      diagnostics = {
        auto_open = false,
        filter = function(items)
          return vim.tbl_filter(function(item)
            local cwd = vim.fn.getcwd()
            return item.filename:find(cwd .. '/', 1, true)
          end, items)
        end,
      },
    },
    auto_close = true,
  }
}
