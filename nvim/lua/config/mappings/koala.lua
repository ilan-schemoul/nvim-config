local library = require('config/koala_prompts')
local set = require('config/mappings/utils').set
local internal_claude_api = require('config/api/claude')

local letter_to_prompt = {
  c = library.commit,
  p = library.gitlab_push,
  r = library.review,
}

for letter, opts in pairs(letter_to_prompt) do
  set("k" .. letter, function()
    internal_claude_api.send_with_model(opts.model, opts.prompt)
  end)
end
