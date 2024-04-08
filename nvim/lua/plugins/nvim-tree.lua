return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { "<leader>t", "<cmd>NvimTreeToggle<cr>" },
  },
  opts = {
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set("n", "<C-b>", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    end
  },
}
