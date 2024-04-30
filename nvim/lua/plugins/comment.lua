-- TODO: With 0.10 comes native comment support
return {
    "numToStr/Comment.nvim",
    opts = {
        padding = true,
        sticky = true,
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
