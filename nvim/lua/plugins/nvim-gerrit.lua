local utils = require("config/utils")

return {
  "ilan-schemoul/nvim-gerrit",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- TODO: add dependency
  cmd = { "GerritLoadComments" },
  config = function()
    local qt_opts = {
      url = "https://codereview.qt-project.org/a",
      digest_authentication = false,
      username = os.getenv("GERRIT_USERNAME"),
      password = os.getenv("GERRIT_PASSWORD"),
      debug = false,
    }

    local intersec_opts = {
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
    }

    local opts = utils.is_intersec() and intersec_opts or qt_opts
    require("nvim-gerrit").setup(opts)
  end,
}
