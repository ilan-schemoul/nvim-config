local library = require('config/library')

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal = {
      split_width_percentage = 0.4,
    }
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
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", function()
      local current_buf = vim.api.nvim_get_current_buf()
      local file_path = vim.api.nvim_buf_get_name(current_buf)
      local current_row = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[1]
      local claude = require("claudecode")
      claude.send_at_mention(file_path, current_row, current_row, "ClaudeCodeSend")

    end, mode = "n", desc = "Send to Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
     desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
    },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },

    -- My library
    { "<leader>ag", "<cmd>ClaudeCodeSendText " .. library.commit .. "<cr>", },
    { "<leader>ap", "<cmd>ClaudeCodeSendText " .. library.gitlab_push .. "<cr>", },
  },
}
