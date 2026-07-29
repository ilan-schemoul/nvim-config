local library = require('config/library')
local set = require('config/mappings/utils').set
local internal_claude_api = require('config/api/claude')

local letter_to_prompt = {
  c = library.commit,
  p = library.gitlab_push,
  r = library.review,
}

for letter, prompt in pairs(letter_to_prompt) do
  set("k" .. letter, function()
    internal_claude_api.send(prompt)
  end)
end
