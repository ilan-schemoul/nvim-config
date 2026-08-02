-- ast-grep rules driving the `Telescope ast_grep` picker
local M = {}

-- todo: create rule checking in the returns

local sender_rule = [[
language: csharp
rule:
  any:
    - kind: method_declaration
      has:
        field: returns
        regex: REPLACEME
    - kind: object_creation_expression
      regex: REPLACEME
]]

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
        regex: ^REPLACEME.*
]]

local rule_template
local force_word
local default_word

function M.find_wolverine_handler(word)
  force_word = word
  default_word = vim.fn.expand("<cword>")

  rule_template = caller_rule
  vim.cmd('Telescope ast_grep')
end

function M.find_wolverine_sender(word)
  force_word = word
  default_word = vim.fn.expand("<cword>")

  rule_template = sender_rule
  vim.cmd('Telescope ast_grep')
end

-- Telescope command generator: turns the prompt into an ast-grep invocation
function M.build_command(prompt)
  local word = force_word or prompt

  if prompt == "" then
    word = default_word
  end

  local rule = rule_template:gsub("REPLACEME", word)

  return {
    "ast-grep", -- For Linux, use `ast-grep` instead of `sg`
    "scan",
    "--inline-rules",
    rule,
    "--json=stream",
  }
end

return M
