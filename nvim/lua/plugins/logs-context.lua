return {
    "git@github.com:ilan-schemoul/logs-context.git",
    opts = {},
    enabled = os.getenv("IS_INTERSEC") == "true",
    config = function()
        require("logs-context").setup()
    end,
}
