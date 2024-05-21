return {
    "m00qek/baleia.nvim",
    config = function()
        require("baleia").setup({
            colors = "NR_16",
        })

        vim.cmd([[
            let s:baleia = luaeval("require('baleia').setup { }")
            command! BaleiaColorize call s:baleia.once(bufnr('%'))
            autocmd BufNewFile,BufRead behave_logs,behave_steps_output call s:baleia.once(bufnr('%'))
            " autocmd BufWinEnter behave_logs,behave_steps_output call s:baleia.automatically(bufnr('%'))
        ]])
    end,
}
