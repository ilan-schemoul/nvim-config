local commit_prompt = [[
Write me a good commit message for the current staged changes.
Read past commit messages to follow format.
Also read (check if not in cache, otherwise cache it (path is/tmp/confluence_changes.md))
https://metalgear.atlassian.net/wiki/spaces/MG/pages/786235397/Creating+and+reviewing+changes
Commit it. If I am on main create a ilan/<branch_name>.
Branch name must be concise, relevant and unique.

You are allowed to warn me if you notice obvious mistakes. I do not ask to make
a comprehensive one-hour review. Simply, if there are any clear mistakes warn me.
]]

local commit = {
  prompt = commit_prompt,
  model = "sonnet"
}

local gitlab_push_prompt = [[
Open in chrome a pre-filled gitlab mr. Never create the mr yourself.

Be concise in the context please. Do not overexplain.

Always follow the template for mr of gitlab.

You should mostly use the commit message for the context.

Read https://metalgear.atlassian.net/wiki/spaces/MG/pages/786235397/Creating+and+reviewing+changes
  (check if page is cached in ~/.claude_cache/standard_changes.md. If not fetch and cache).

Assign myself (ilan schemoul). (if you need ids, check if cache
~/.claude_cache/gl_ids is filled. Otherwise fetch ids and cache it)
]]

local gitlab_push = {
  prompt = gitlab_push_prompt,
  model = "haiku"
}

local review_prompt = "Start a review, following the relevant skill."

local review = {
  prompt = review_prompt,
  model = "opus"
}

return {
  commit = commit,
  gitlab_push = gitlab_push,
  review = review,
}
