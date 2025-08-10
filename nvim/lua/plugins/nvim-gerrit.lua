return {
  "ilan-schemoul/nvim-gerrit", -- my plugin
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  enabled = os.getenv("GERRIT_USERNAME") ~= nil,
  -- TODO: add dependency
  cmd = { "GerritLoadComments" },
  opts = {
    url = "https://git.corp/a",
    digest_authentication = true,
    username = os.getenv("GERRIT_USERNAME"),
    password = os.getenv("GERRIT_PASSWORD"),
  },
}
