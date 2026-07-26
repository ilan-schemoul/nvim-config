M = {}

-- todo: create rule checking in the returns

local caller_rule = [[
language: csharp
rule:
  kind: method_declaration
  has:
    field: parameters
    has:
      kind: parameter
      has:
        field: type
        regex: ^REPLACEME$
]]

M.search_handler = function(prompt)
  local rule
  if M.mode == "handler" then
    rule = caller_rule:gsub("REPLACEME", prompt)
  else -- sender
    vim.notify('error')
  end

  return {
    "ast-grep", -- For Linux, use `ast-grep` instead of `sg`
    "scan",
    "--inline-rules",
    rule,
    "--json=stream",
  }
end

M.set_mode = function(mode)
  M.mode = mode
end

return M
