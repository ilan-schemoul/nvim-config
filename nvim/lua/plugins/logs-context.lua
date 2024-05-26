return {
    "git@github.com:ilan-schemoul/logs-context.git",
    opts = {},
    config = function()
        require("logs-context").setup()
    end,
}
