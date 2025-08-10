local custom_commands = require("config/custom-commands")

return {
    "chrisgrieser/nvim-early-retirement",
    opts = {
        minimumBufferNum = 5,
        retirementAgeMins = 5,
        deleteFunction = custom_commands.close_buffer_if_not_last,
    },
    event = "VeryLazy",
}
