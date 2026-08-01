local api = require("config/api")

return {
    enabled = false,
    "chrisgrieser/nvim-early-retirement",
    opts = {
        minimumBufferNum = 5,
        retirementAgeMins = 5,
        deleteFunction = api.buffer.close_if_not_last,
    },
    event = "VeryLazy",
}
