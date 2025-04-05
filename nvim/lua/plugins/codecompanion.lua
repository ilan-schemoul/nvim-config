local is_intersec = require("config/utils").is_intersec()
local adapter = is_intersec and "ollama" or "anthropic"
local cortex = {
  schema = {
    model = {
      default = "deepseek-r1:14b",
    },
  },
  env = {
    url = 'http://cortex.corp:11434',
    api_key = "NONE",
  },
  headers = {
    ["Content-Type"] = "application/json",
    ["Authorization"] = "Bearer ${api_key}",
  },
  parameters = {
    sync = true,
  },
}

local chat = {
  adapter = adapter,
  slash_commands = {
    ["file"] = {
      -- Location to the slash command in CodeCompanion
      callback = "strategies.chat.slash_commands.file",
      description = "Select a file using Telescope",
      opts = {
        provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
        contains_code = true,
      },
    },
  },
  keymaps = {
    stop = {
      modes = {
        n = "Q",
      },
      index = 5,
      callback = "keymaps.stop",
      description = "Stop Request",
    },
  },
}

return {
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" }, -- Command to open the companion window
  keys = {
    { "<leader>fc", ":CodeCompanionChat toggle<CR>" },
    { "<leader>fc", ":CodeCompanionChat toggle<CR>" },
    { "<leader>fC", ":CodeCompanionChat<CR>" },
    { "<leader>fp", ":CodeCompanion<CR>" },
    { "<leader>fp", ":'<,'>CodeCompanion<CR>", mode = "v" },
    { "<leader>fa", ":CodeCompanionActions<CR>" },
    { "<leader>fa", ":'<,'>CodeCompanionActions<CR>", mode = "v" },
    { "<leader>f/", ":'CodeCompanionCmd<CR>" },
  },
  opts = {
    strategies = {
      chat = chat,
      inline = {
        adapter = adapter,
      },
    },
    adapters = {
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", cortex)
      end,
    },
  },
}
