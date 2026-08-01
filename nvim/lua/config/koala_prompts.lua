local _finding_jira_ticket = [[
# Finding Jira ticket

  As per the standard, you can add a reference to the ticket if you have one. If you do not
  know it, you can find on the list of Jira tickets. Ask me if it's a related or a close.

  Example: the commit's content is about implementing table XYZ, you find in Jira list,
  implementing XYZ with ticket id MG-1234. You ask me if related or closed. I answer close,
  you add "close MG-1234".

  Example 2: the commit's content is about fixing the bug "foo". You search in the Jira list,
  you find something that seems closely related but you are not sure. You ask for confirmation
  of the relevance of the ticket, then ask if related/closed if the ticket is relevant.

  Always provide a link and the title to the related ticket in the chat.
]]

local commit_prompt = [[
# Standard

Read with cache the standard:
https://metalgear.atlassian.net/wiki/spaces/MG/pages/786235397/Creating+and+reviewing+changes

No need to summarize it to me, I know it. Just read it. If anything comes in contradiction to
the standard, just explain briefly the problem to me.

]] .. _finding_jira_ticket .. [[

# How to commit

Write me a good commit message for the current staged changes.
Read past commit messages to follow format.
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
# Push to Gitlab

Open in chrome a pre-filled gitlab mr. Never create the mr yourself.

Be concise in the context please. Do not overexplain.

Always follow the template for mr of gitlab.

You should mostly use the commit message for the context.

Read https://metalgear.atlassian.net/wiki/spaces/MG/pages/786235397/Creating+and+reviewing+changes
  (check if page is cached in ~/.claude_cache/standard_changes.md. If not fetch and cache).

Assign myself (ilan schemoul). (use ~/.claude_cache/gl_ids as your cache).
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
