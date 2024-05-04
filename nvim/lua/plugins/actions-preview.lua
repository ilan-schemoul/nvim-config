return {
  "aznhe21/actions-preview.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function(_, opts)
    require("actions-preview").setup({
      backend = { "telescope", "nui" },
      telescope = vim.tbl_extend(
        "force",
        -- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
        require("telescope.themes").get_cursor(),
        {
          make_value = nil,
          make_make_display = nil,
          previewer = false,
        }
      ),
    })
  end,
  keys = {
    { "<leader>a", "<cmd>lua require('actions-preview').code_actions()<cr>" },
  },
}
