local set = require('config/mappings/utils').set
local internal_claude_api = require('config/api/claude')

local letter_to_prompt = {
  c = "/commit",
  p = "/push",
  r = "/mg-review"
}

for letter, command in pairs(letter_to_prompt) do
  set("k" .. letter, function()
    internal_claude_api.send(command)
  end, "Send " .. command .. " to Claude")
end
