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
      regex101 = {
        name = "regex101",
        handle = function(mode, line, _)
          local helper = require("gx.helper")
          local valid_flags = "gimsuyxUJ"
          local start = 1

          while true do
            -- /regex/, escaped slashes not counted as the closing delimiter
            local i, j, regex = string.find(line, "/(.-[^\\/])/", start)
            if not i then
              return
            end

            local afterLastSlash = j + 1
            -- If we have /blabla/ABC => ABC
            local flags = line:match("^%a*", afterLastSlash)
            if flags:find("[^" .. valid_flags .. "]") then
              flags = ""
            end

            if helper.check_if_cursor_on_url(mode, i, j + #flags) then
              local url = "https://regex101.com/?regex=" .. helper.urlencode(regex)
              if flags ~= "" then
                url = url .. "&flags=" .. flags
              end
              return url
            end

            start = j + 1
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
