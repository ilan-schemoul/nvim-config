-- TODO: With 0.10 comes native comment support
return {
    "ilan-schemoul/Comment.nvim",
    event = "VimEnter",
    opts = {
        padding = true,
        sticky = true,
        always_use_block = true,
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
