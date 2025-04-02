return {
  "nvim-neorg/neorg",
  version = "v9.x.x",
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.esupports.indent"] = {
          config = {
            format_on_enter = true,
            format_on_escape = true,
          },
        },
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.keybinds"] = {
          config = {
            default_keybinds = true,
          },
        },
      },
    })
    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "norg",
      callback = function()
        vim.keymap.set("i", "<C-b>", "<Plug>(neorg.itero.next-iteration)", { buffer = true })
      end,
    })

    vim.wo.foldlevel = 99
  end,
}
