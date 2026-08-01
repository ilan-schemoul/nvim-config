local mappings_utils = require('config/mappings/utils')
local api = require("config/api")

local set = mappings_utils.set

local pg_url = "postgresql://postgres:p4ssw0rd@localhost:5435/local-liquid"

-- letter -> { name, cmd } for toggle_or_create_sticky_term
local sticky_term_cmds = {
  p = { name = "pgcli", cmd = { "pgcli", pg_url } },
  l = { name = "alogs", cmd = { "fish", "-c", "alogs" } },
  -- dotnet watch --project /Users/ilan/code/liquid-server/src/AppHost/AppHost.csproj works too
  a = { name = "aspire", cmd = { "aspire", "run" } },

  cc = { name = "claude_default", cmd = { "claude" } },
  ch = { name = "claude_haiku", cmd = { "claude", "--model", "haiku" } },
  cs = { name = "claude_sonnet", cmd = { "claude", "--model", "sonnet" } },
  co = { name = "claude_opus", cmd = { "claude", "--model", "opus" } },

  m = { name = "calc", cmd = { "calc" } },
  r = { name = "csharprepl", cmd = { "csharprepl" } },
}

for key, term in pairs(sticky_term_cmds) do
  set("o" .. key, function()
    api.toggle_or_create_sticky_term(term.name, term.cmd)
  end)
  set("o" .. key:upper(), function()
    api.toggle_or_create_sticky_term(term.name, term.cmd, {
      force_new = true,
    })
  end)
end

-- <leader>o<letter> open fish in given directory (false = no override, use current session dir)
local sticky_fish_cwds = {
  t = false,
  f = "/Users/ilan/code/liquid-server/test/Functional.Tests",
  u = "/Users/ilan/code/liquid-server/test/Unit.Tests",
  x = "/Users/ilan/code/liquid-server/src/LiquidCtl",
}

for key, cwd in pairs(sticky_fish_cwds) do
  set("o" .. key, function()
    api.toggle_or_create_fish_in_cwd(cwd or nil)
  end)
end

set("go", api.toggle_lazygit)
set("og", api.toggle_lazygit)
set("oG", function() api.toggle_lazygit(true) end)

