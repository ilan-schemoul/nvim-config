return {
    "git@github.com:ilan-schemoul/logs-context.git",
    opts = {},
    enabled = require("config/utils").is_intersec,
    config = function()
        require("logs-context").setup()
    end,
}
