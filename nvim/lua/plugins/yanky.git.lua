return {
  "gbprod/yanky.nvim",
  config = function()
    vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
    vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

    vim.keymap.set("n", "<leader>yh", '<cmd>Telescope yank_history<cr>')
    vim.keymap.set("n", "<leader>yk", "<Plug>(YankyPreviousEntry)")
    vim.keymap.set("n", "<leader>yj", "<Plug>(YankyNextEntry)")

    vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
    vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
    vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
    vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

    vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
    vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
    vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
    vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

    vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
    vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

    vim.keymap.set({"n","x"}, "y", "<Plug>(YankyYank)")

    vim.keymap.set({ "o", "x" }, "gv", function()
      require("yanky.textobj").last_put()
    end, {})

    require("yanky").setup({
      ring = {
        permanent_wrapper = require("yanky.wrappers").remove_carriage_return,
      },
    })
  end,
}

