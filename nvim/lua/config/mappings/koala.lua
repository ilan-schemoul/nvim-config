local api = require('config/api')
local set = api.keymap.leader

local letter_to_prompt = {
  c = "/commit",
  p = "/push",
  r = "/mg-review"
}

for letter, command in pairs(letter_to_prompt) do
  set("k" .. letter, function()
    api.claude.send(command)
  end, "Send " .. command .. " to Claude")
end
