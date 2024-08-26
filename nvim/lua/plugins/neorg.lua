return {
  "nvim-neorg/neorg",
  version = "v7.0.0",
  ft = "norg", -- lazy load on file type
  cmd = "Neorg", -- lazy load on command
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'norg',
      callback = function (_)
        vim.g.maplocalleader = "g"
      end,
    })
    require("neorg").setup({
      load = {
        ["core.defaults"] = {
          config = {
            disable = {
              "core.esupports.indent",
            },
          },
        },
        ["core.esupports.indent"] = {
          config = {
            format_on_enter = false,
            format_on_escape = false,
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
