local api = require('config/api')

local open = function(model)
  return function()
    vim.cmd("ClaudeCode " .. "--model " .. model)
  end
end

return {
  "ilan-schemoul/claudecode.nvim",
  branch = "fix/selection-empty-line-selection", -- pending upstream PR: https://github.com/coder/claudecode.nvim/pull/310
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal = {
      split_width_percentage = 0.4,
      provider = api.claude.terminal_provider,
      show_native_term_exit_tip = false,
    },

  },
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSelectModel",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeStatus",
    "ClaudeCodeStart",
    "ClaudeCodeStop",
    "ClaudeCodeOpen",
    "ClaudeCodeClose",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeCloseAllDiffs",
  },
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },

    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>ah", open("haiku"), desc = "Toggle Claude" },
    { "<leader>aS", open("sonet"), desc = "Toggle Claude" },
    { "<leader>ao", open("opus"), desc = "Toggle Claude" },

    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>af", api.claude.open_fterm, desc = "Add current buffer" },

    { "<leader>as", "<cmd>.ClaudeCodeSend<cr>", mode = "n", desc = "Send to Claude" },

    { "<leader>as", "<cmd>'<,'>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },

    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
     desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
    },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
