local custom_commands = require("config/custom-commands")

return {
    "chrisgrieser/nvim-early-retirement",
    opts = {
        retirementAgeMins = 10,
        deleteFunction = custom_commands.close_buffer_if_not_last,
    },
    event = "VeryLazy",
}
