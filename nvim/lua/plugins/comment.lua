return {
    "ilan-schemoul/Comment.nvim",
    -- dir = "~/code/forks/Comment.nvim",
    event = "VimEnter",
    opts = {
        padding = true,
        sticky = true,
        -- NOTE: my fork adds this
        only_block_ft = { 'c' },
        toggler = {
            line = "<leader>cc",
            block = "<leader>CC",
        },
        opleader = {
            line = "<leader>c",
            block = "<leader>C",
        },
        extra = {
            above = "<leader>cO",
            below = "<leader>co",
            eol = "<leader>cA",
        },
        mappings = {
            basic = true,
            extra = true,
        },
    }
}
