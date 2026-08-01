local api = require("config/api")

local set = api.keymap.leader

local pg_url = "postgresql://postgres:p4ssw0rd@localhost:5435/local-liquid"

-- letter -> { name, cmd } for api.sticky.toggle_or_create
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
    api.sticky.toggle_or_create(term.name, term.cmd)
  end, "Toggle " .. term.name .. " terminal")
  set("o" .. key:upper(), function()
    api.sticky.toggle_or_create(term.name, term.cmd, {
      force_new = true,
    })
  end, "Open new " .. term.name .. " terminal")
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
    api.sticky.fish_in_cwd(cwd or api.file.cwd())
  end, "Toggle fish terminal" .. (cwd and (" in " .. cwd) or ""))
end

set("go", api.sticky.lazygit.toggle, "Toggle lazygit")
set("og", api.sticky.lazygit.toggle, "Toggle lazygit")
set("oG", function() api.sticky.lazygit.toggle(true) end, "Open new lazygit instance")

