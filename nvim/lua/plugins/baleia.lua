return {
    "m00qek/baleia.nvim",
    branch = "linebreaks",
    config = function()
        local baleia = require('baleia').setup({
            colors = {
                [00] = '#494D64',
                [08] = '#5B6078',

                [01] = '#ED8796',
                [09] = '#ED8796',

                [02] = '#A6DA95',
                [10] = '#A6DA95',

                [03] = '#EED49F',
                [11] = '#EED49F',

                [04] = '#8AADF4',
                [12] = '#8AADF4',

                [05] = '#F5BDE6',
                [13] = '#F5BDE6',

                [06] = '#8BD5CA',
                [14] = '#8BD5CA',

                [07] = '#B8C0E0',
                [15] = '#A5ADCB',
            },
        })

        vim.api.nvim_create_user_command("BaleiaColorize", function()
            local bufnr = vim.api.nvim_get_current_buf()
            baleia.once(bufnr)
        end, {})

        vim.api.nvim_create_user_command("BaleiaLogs", function()
            baleia.logger.show()
        end, {})

        vim.api.nvim_create_autocmd(
            {
                "FileType",
            },
            {
                pattern = "behave_log",
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    baleia.once(bufnr)
                end
            }
        )
    end,
}
