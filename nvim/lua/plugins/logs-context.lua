-- Allows to see the step "Then/When/Given" at the top of the screen
-- When I open logs from behave
return {
    "git@github.com:ilan-schemoul/logs-context.git",
    opts = {},
    enabled = false,
    -- enabled = require("config/utils").is_intersec,
    config = function()
        require("logs-context").setup()
    end,
}
