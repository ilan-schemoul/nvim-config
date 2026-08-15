M = {}

local function bandit_exec(keys)
  if vim.fn.maparg('<leader>' .. keys, 'n', false, true) then
    vim.fn.feedkeys(' ' .. keys)
  end
end

function M.accept_local()
  bandit_exec('dl')
  require('git-conflict').choose('ours')
end

function M.accept_remote()
  bandit_exec('dr')
  require('git-conflict').choose('theirs')
end

function M.accept_both()
  bandit_exec('db')
  require('git-conflict').choose('theirs')
end

function M.accept_non_conflicting()
  vim.fn.feedkeys('<leader>da')
end

function M.none()
  require('git-conflict').choose('none')
end

return M
