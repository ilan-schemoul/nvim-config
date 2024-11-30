local utils = require("config/utils")
local FORCE_ENABLE_PLUGIN = false

return {
  "ilan-schemoul/nvim-gerrit",
  cmd = { "GerritLoadComments" },
  enabled = utils.is_intersec() or FORCE_ENABLE_PLUGIN,
  opts = {
    url = "https://git.corp/a",
    -- cookie = os.getenv("GERRIT_COOKIE"),
    -- TODO:use something like 1password to be more safe. (gerrit plugin
    -- must be updated to support functions instead of just strings)
    digest_authentication = false,
    username = os.getenv("GERRIT_USERNAME"),
    password = os.getenv("GERRIT_PASSWORD"),
    debug = true,
  },
}
