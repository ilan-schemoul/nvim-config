local utils = require("config/utils")

return {
  "ilan-schemoul/nvim-gerrit",
  cmd = { "GerritLoadComments" },
  enabled = utils.is_intersec(),
  opts = {
    url = "https://git.corp/r",
    cookie = os.getenv("GERRIT_COOKIES"),
    debug = true,
  },
}
