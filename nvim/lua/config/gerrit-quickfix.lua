local curl = require "plenary.curl"

local M = {}

M.load_url = function(url)
   -- example url: "https://gerrit.onap.org/r/changes/135045/comments"
    curl.get(url, {
      callback = function(res)
        vim.schedule(function()
          vim.cmd("cexpr []")

          -- Remove )]}'
          local json = res.body:sub(5)

          vim.cmd("set errorformat=%f:%l\\ %m")

          local files = vim.json.decode(json)
          for filename, patch_sets in pairs(files) do
            for _, comment in ipairs(patch_sets) do
              local error = filename .. ":" .. comment.line .. " " .. comment.message
              -- Escape multiline string for vim
              error = error:gsub("\n", "\n\\ ")

              vim.cmd("caddexpr '" .. error .. "'")
            end
          end
        end)
      end,
    })
end

M.load_interactive_input = function()
  vim.ui.input({
    prompt = "Gerrit id",
  }, function(id)
    M.load_url("https://git.corp/r/changes/" .. tostring(id) .. "/comments")
  end)
end

return M
