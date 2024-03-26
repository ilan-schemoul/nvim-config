return {
  "jackMort/ChatGPT.nvim",
  cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions", "ChatGPTRun" },
  opts = {
    api_key_cmd = "op.exe read op://Personal/OPENSSH_API_KEY/credential --no-newline",
    edit_with_instructions = {
      diff = true,
    },
    popup_layout = {
      default = "center",
      center = {
        width = "90%",
        height = "90%",
      },
      right = {
        width = "30%",
        width_settings_open = "50%",
      },
    },
    openai_params = {
      model = "gpt-4-turbo-preview",
    },
    openai_edit_params = {
      model = "gpt-4-turbo-preview",
    },
    keymaps = {
      select_session = "<cr>",
    },
    actions_paths = "~/nvim.ilanschemoul.me/nvim/actions_gpt.json",
  },
  config = function(_, opts)
    require("chatgpt").setup(opts)
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
