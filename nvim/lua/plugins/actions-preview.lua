return {
  "aznhe21/actions-preview.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function(_, opts)
    require("actions-preview").setup({
      backend = { "nui", "telescope" },
      nui = {
        layout = {
          position = {
            row = "1",
            col = "0",
          },
          size = {
            width = "90%",
            height = "30%"
          },
          relative = "cursor",
        },
      },
    })
  end,
  keys = {
    { "<leader>a", "<cmd>lua require('actions-preview').code_actions()<cr>" },
  },
}
