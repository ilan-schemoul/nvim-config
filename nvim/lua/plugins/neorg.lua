return {
  "nvim-neorg/neorg",
  ft = "norg", -- lazy load on file type
  cmd = "Neorg", -- lazy load on command
  dependencies = { "nvim-lua/plenary.nvim", "luarocks.nvim" },
  config = function()
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
            neorg_leader = "g",
            hook = function(keybinds)
              -- keybinds.remap_event("norg", "i", "<C-n>", "core.itero.next-iteration<CR>")
              keybinds.remap_key("norg", "i", "<M-CR>", "<C-b>")
              -- keybinds.remap_key("norg", "n", "<M-CR>", "<C-CR>")
            end,
          },
        },
      },
    })

    vim.wo.foldlevel = 99
  end,
}
