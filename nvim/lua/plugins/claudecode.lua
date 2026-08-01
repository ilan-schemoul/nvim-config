local my_claude_api = require('config/api/claude')

local open = function(model)
  return function()
    vim.cmd("ClaudeCode " .. "--model " .. model)
  end
end

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal = {
      split_width_percentage = 0.4,
      provider = my_claude_api.claude_terminal_provider,
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
    { "<leader>af", my_claude_api.open_fterm, desc = "Add current buffer" },

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
