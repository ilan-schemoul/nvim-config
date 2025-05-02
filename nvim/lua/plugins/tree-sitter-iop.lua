return {
  -- "https://github.com/ilan-schemoul/tree-sitter-iop",
  build = ":TSUpdate",
  dir = "~/code/tree-sitter-iop",
  opts = {
    -- local_directory = "~/code/tree-sitter-iop/",
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function(opts)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "iop",
        callback = function()
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
          local utils = require("config/utils")
          if not ok or not stats or stats.size > utils.max_treesitter_filesize then
            vim.bo.ft = 'd'
          end
        end
    })
    require("tree-sitter-iop").setup(opts)
  end,
}
