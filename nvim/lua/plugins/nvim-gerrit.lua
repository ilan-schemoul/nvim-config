local utils = require("config/utils")
local FORCE_ENABLE_PLUGIN = false

return {
  "ilan-schemoul/nvim-gerrit",
  cmd = { "GerritLoadComments" },
  enabled = utils.is_intersec() or FORCE_ENABLE_PLUGIN,
  opts = {
    url = "https://git.corp",
    cookie = function()
      local handle = io.popen("cp ~/snap/firefox/common/.mozilla/firefox/*default-release/cookies.sqlite /tmp/cookies.sqlite "
                              .. "&& sqlite3 /tmp/cookies.sqlite 'SELECT value FROM moz_cookies WHERE name=\"GerritAccount\" ;'"
                              .. "&& rm /tmp/cookies.sqlite")
      assert(handle, "Gerrit cookie: popen fail")
      local result = handle:read("*a")
      assert(handle, "Gerrit cookie: failed to read output")
      handle:close()
      assert(#result, "Gerrit cookie: no output")
      -- Remove the \n
      result = result:sub(1, -2)
      return "GerritAccount=" .. result
    end,
    debug = false,
  },
  setup = function()
  end,
}
