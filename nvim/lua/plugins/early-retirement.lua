local custom_commands = require("config/custom-commands")

return {
    "ilan-schemoul/nvim-early-retirement",
    opts = {
      -- 1h30
        retirementAgeMins = 90,
        -- This is what my fork provides.
        -- Necessary as to not close any tab.
        deleteFunction = custom_commands.close_buffer_if_not_last,
    },
    event = "VeryLazy",
}
