-- local is_intersec = require("config/utils").is_intersec() and false
-- local chat_adapter = is_intersec and "cortex" or "anthropic"
-- local inline_adapter = is_intersec and "cortex" or "haiku"
-- local cortex = {
--   schema = {
--     model = {
--       default = "devstral:24b",
--     },
--   },
--   env = {
--     url = 'http://cortex.corp:11434',
--     api_key = "NONE",
--   },
--   headers = {
--     ["Content-Type"] = "application/json",
--     ["Authorization"] = "Bearer ${api_key}",
--   },
--   parameters = {
--     sync = true,
--   },
-- }
--
-- local ovh = {
--   schema = {
--     model = {
--       default = "Qwen2.5-Coder-32B-Instruct",
--     },
--   },
--   env = {
--     url = 'https://oai.endpoints.kepler.ai.cloud.ovh.net',
--     api_key = "OVH_API_KEY",
--   },
--   headers = {
--     ["Content-Type"] = "application/json",
--     ["Authorization"] = "Bearer ${api_key}",
--   },
--   parameters = {
--     sync = true,
--   },
-- }

local chat = {
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

local function setup_fidget_hooks()
  local progress = require("fidget.progress")
  local handle = nil

  local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequest*",
    group = group,
    callback = function(request)
      if request.match == "CodeCompanionRequestStarted" then
        local adapter_name = "TODO"
        local model_name = "TODO"
        handle = progress.handle.create({
          title = " Requesting assistance",
          lsp_client = {
            name = string.format("CodeCompanion (%s - %s)", adapter_name, model_name),
          },
        })
      elseif request.match == "CodeCompanionRequestFinished" then
        if handle then
          handle:finish()
        end
      end
    end,
  })
end

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
    interactions = {
      chat = {
        adapter = {
          name = "anthropic",
          model = "claude-sonnet-4-6",
        },
      },
      inline = {
        adapter = {
          name = "anthropic",
          model = "claude-haiku-4-5-20251001",
        },
      },
    },
  },
  config = function(_, opts)
    require("codecompanion").setup(opts)
    setup_fidget_hooks()
  end,
}
