return {
  "chrishrb/gx.nvim",
  -- Search on the internet
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" }, desc = "Open link/search under cursor in browser" } },
  cmd = { "Browse" },
  opts = {
    select_prompt = false,
    handlers = {
      jira = {
        name = "jira", -- set name of handler
        handle = function(mode, line, _)
          local ticket_nb = require("gx.helper").find(line, mode, "MG%-(%d+)")

          if ticket_nb and #ticket_nb <= 5 then
            return "https://metalgear.atlassian.net/browse/MG-" .. ticket_nb
          end
        end,
      },
    },
  },
  init = function()
    vim.g.netrw_nogx = 1 -- disable netrw gx
  end,
  config = true, -- default settings
  submodules = false, -- not needed, submodules are required only for tests
}
