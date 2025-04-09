local is_intersec = require("config/utils").is_intersec()
local chat_adapter = is_intersec and "ovh" or "anthropic"
local inline_adapter = is_intersec and "ovh" or "haiku"
local cortex = {
  schema = {
    model = {
      default = "qwen2.5-coder:32b",
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

local ovh = {
  schema = {
    model = {
      default = "Qwen2.5-Coder-32B-Instruct",
    },
  },
  env = {
    url = 'https://oai.endpoints.kepler.ai.cloud.ovh.net',
    api_key = "OVH_API_KEY",
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
  adapter = chat_adapter,
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
    options = {
      modes = {
        n = "g?",
      },
      callback = "keymaps.options",
      description = "Options",
      hide = true,
    },
    stop = {
      modes = {
        n = "Q",
      },
      index = 5,
      callback = "keymaps.stop",
      description = "Stop Request",
    },
  },
  tools = {
    ["mcp"] = {
      -- Prevent mcphub from loading before needed
      callback = function()
        return require("mcphub.extensions.codecompanion")
      end,
      description = "Call tools and resources from the MCP Servers"
    }
  }
}
-- New comment added here

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "j-hui/fidget.nvim",
    "ravitemer/mcphub.nvim",
  },
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
    { "<leader>fA", ":%CodeCompanionChat Add<cr>" },
    { "<leader>fA", ":'<,'>CodeCompanionChat Add<cr>", mode = "v" }
  },
  opts = {
    strategies = {
      chat = chat,
      inline = {
        adapter = inline_adapter,
      },
    },
    adapters = {
      cortex = function()
        return require("codecompanion.adapters").extend("ollama", cortex)
      end,
      ovh = function()
        return require("codecompanion.adapters").extend("openai_compatible", ovh)
      end,
      haiku = function()
        return require("codecompanion.adapters").extend("anthropic", {
          schema = {
            model = {
              default = "claude-3-5-haiku-latest",
            },
          },
        })
      end,
    },
  },
  config = function(_, opts)
    require("codecompanion").setup(opts)
    require("3rd/codecompanion-fidget-spinner"):init()
  end,
}
