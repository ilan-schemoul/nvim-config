local is_intersec = require("config/utils").is_intersec()
local chat_adapter = is_intersec and "cortex" or "anthropic"
local inline_adapter = is_intersec and "cortex" or "haiku"
local cortex = {
  schema = {
    model = {
      default = "devstral:24b",
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
}

local prompts = {
  ["Commit"] = {
    strategy = "chat",
    description = "Write commit for me",
    prompts = {
      {
        -- TODO: straight do a system command to get the last 20 commits and the diff
        role = "user",
        content = [[You are an excellent software engineer who makes explicit yet succint commit message. You deeply care about being consistent with the commit history. You are seen as the best commiter of your company and you are proud of that.
        Write a commit for me.
        Please follow following instructions:
        - First do a git log of twenty last commits to understand commit formats.
        - Then do a git diff to understand the changes.
        - Then write a commit message for me.
        - Do not add too many details, be explicit but concise.
        - Do not follow conventional commit convention.
        Use the tool @cmd_runner to execute git commands]],
      },
    },
  },
}

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "j-hui/fidget.nvim",
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
    prompt_library = prompts,
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
