-- Everything vide coded, because I ain't spending 2 days writing down icons.
--
local rules = {
  -- AI
  { pattern = "claude", icon = "󱚝 ", color = "orange" },
  { pattern = "minuet", icon = "󱚝 ", color = "orange" },

  -- git
  { pattern = "lazygit", icon = "󰊢 ", color = "orange" },
  { pattern = "hunk", icon = "󰊢 ", color = "orange" },
  { pattern = "conflict", icon = "󰩌 ", color = "red" },
  { pattern = "take ", icon = "󰩌 ", color = "red" },
  { pattern = "diff", icon = "󰦓 ", color = "orange" },
  { pattern = "stage", icon = "󰊢 ", color = "orange" },
  { pattern = "merge request", icon = "󰮠 ", color = "orange" },
  { pattern = "glab", icon = "󰮠 ", color = "orange" },
  { pattern = "blame", icon = "󰊢 ", color = "orange" },

  -- LSP / code intelligence
  { pattern = "%.net", icon = "\u{E77F} ", color = "purple" },
  { pattern = "lsp", icon = "\u{F085} ", color = "blue" },
  { pattern = "definition", icon = "\u{F0128} ", color = "blue" },
  { pattern = "implementation", icon = "\u{F0877} ", color = "blue" },
  { pattern = "references", icon = "\u{F0C9} ", color = "blue" },
  { pattern = "symbol", icon = "\u{EA8B} ", color = "blue" },
  { pattern = "hover", icon = "󰋽 ", color = "blue" },
  { pattern = "signature", icon = "󰊕 ", color = "blue" },
  { pattern = "code action", icon = "\u{F0335} ", color = "yellow" },
  { pattern = "node action", icon = "\u{F0335} ", color = "yellow" },
  { pattern = "outline", icon = "󰙅 ", color = "blue" },
  { pattern = "function", icon = "󰊕 ", color = "purple" },
  { pattern = "parameter", icon = "󰏫 ", color = "purple" },
  { pattern = "local scope", icon = "󰅩 ", color = "purple" },
  { pattern = "handler", icon = "󰊕 ", color = "purple" },
  { pattern = "sender", icon = "󰊕 ", color = "purple" },

  -- pickers / navigation
  { pattern = "telescope", icon = "\u{F002} ", color = "blue" },
  { pattern = "easypick", icon = "\u{F002} ", color = "blue" },
  { pattern = "grep", icon = "\u{F002} ", color = "green" },
  { pattern = "smart open", icon = "\u{F07C} ", color = "green" },
  { pattern = "fuzzy", icon = "\u{F002} ", color = "green" },
  { pattern = "list ", icon = "\u{F0CA} ", color = "cyan" },
  { pattern = "quickfix", icon = "\u{F0219} ", color = "cyan" },
  { pattern = "bookmark", icon = "󰃀 ", color = "purple" },
  { pattern = "jump", icon = "󱡔 ", color = "azure" },
  { pattern = "zoxide", icon = "󰉋 ", color = "azure" },
  { pattern = "explorer", icon = "󰉋 ", color = "azure" },
  { pattern = "oil", icon = "󰉋 ", color = "azure" },
  { pattern = "directory", icon = "󰉋 ", color = "azure" },
  { pattern = "fold", icon = "󰡍 ", color = "grey" },
  { pattern = "go to next", icon = "󰒭 ", color = "azure" },
  { pattern = "go to previous", icon = "󰒮 ", color = "azure" },
  { pattern = "^next", icon = "󰒭 ", color = "azure" },
  { pattern = "^previous", icon = "󰒮 ", color = "azure" },
  { pattern = "^move", icon = "󰆾 ", color = "azure" },
  { pattern = "center", icon = "󰉠 ", color = "cyan" },
  { pattern = "resume", icon = "󰑙 ", color = "green" },
  { pattern = "repeat", icon = "󰑙 ", color = "green" },

  -- editing
  { pattern = "comment", icon = "󰆉 ", color = "grey" },
  { pattern = "todo", icon = "\u{F0F5} ", color = "yellow" },
  { pattern = "select", icon = "󰒅 ", color = "purple" },
  { pattern = "paste", icon = "󰆒 ", color = "yellow" },
  { pattern = "yank", icon = "󰅇 ", color = "yellow" },
  { pattern = "replace", icon = "󰛔 ", color = "blue" },
  { pattern = "undo", icon = "󰕌 ", color = "yellow" },
  { pattern = "reset", icon = "󰦛 ", color = "red" },
  { pattern = "align", icon = "󰉢 ", color = "cyan" },
  { pattern = "surround", icon = "󰅲 ", color = "cyan" },
  { pattern = "macro", icon = "󰑊 ", color = "red" },
  { pattern = "debug log", icon = "󰃤 ", color = "red" },
  { pattern = "note", icon = "󰠮 ", color = "yellow" },
  { pattern = "neorg", icon = "󰠮 ", color = "green" },
  { pattern = "memory", icon = "󰠮 ", color = "yellow" },
  { pattern = "dictionary", icon = "󰓆 ", color = "green" },
  { pattern = "spell", icon = "󰓆 ", color = "green" },
  { pattern = "word", icon = "󰬴 ", color = "green" },
  { pattern = "color", icon = "󰏘 ", color = "purple" },

  -- misc
  { pattern = "help", icon = "󰋖 ", color = "cyan" },
  { pattern = "messages", icon = "󰍡 ", color = "blue" },
  { pattern = "mason", icon = "󰏖 ", color = "purple" },
  { pattern = "plugin", icon = "󰏖 ", color = "purple" },
  { pattern = "rebuild", icon = "󱌣 ", color = "orange" },
  { pattern = "restart", icon = "󰜉 ", color = "red" },
  { pattern = "reload", icon = "󰜉 ", color = "yellow" },
  { pattern = "config", icon = "\u{F013} ", color = "grey" },
  { pattern = "split", icon = "\u{F0BDC} ", color = "blue" },
  { pattern = "echo", icon = "󰍡 ", color = "grey" },
  { pattern = "^open", icon = "󰏋 ", color = "cyan" },
  { pattern = "^close", icon = "󰅖 ", color = "red" },
  { pattern = "^add", icon = "󰐕 ", color = "green" },
  { pattern = "^remove", icon = "󰍴 ", color = "red" },
  { pattern = "^show", icon = "󰈈 ", color = "cyan" },
  { pattern = "^preview", icon = "󰈈 ", color = "cyan" },
  { pattern = "^send", icon = "󰒊 ", color = "green" },
  { pattern = "^run", icon = "󰐊 ", color = "green" },
  { pattern = "^save", icon = "󰆓 ", color = "green" },
  { pattern = "^create", icon = "󰝒 ", color = "green" },
  { pattern = "^insert", icon = "󰐕 ", color = "green" },
  { pattern = "^accept", icon = "󰄬 ", color = "green" },
  { pattern = "^deny", icon = "󰅖 ", color = "red" },
  { pattern = "^change", icon = "󰏫 ", color = "yellow" },
  { pattern = "^refresh", icon = "󰑐 ", color = "yellow" },
  { pattern = "^continue", icon = "󰐊 ", color = "green" },
  { pattern = "^start", icon = "󰐊 ", color = "green" },
  { pattern = "^cd ", icon = "󰉋 ", color = "azure" },
  { pattern = "^go to", icon = "󱡔 ", color = "azure" },
  { pattern = "^focus", icon = "\u{F2D0} ", color = "blue" },
  { pattern = "^grep", icon = "\u{F002} ", color = "green" },
}

local groups = {
  { "<leader>a", group = "AI / Claude" },
  { "<leader>b", group = "Buffers & splits" },
  { "<leader>c", group = ".NET & comments" },
  { "<leader>d", group = "File explorer" },
  { "<leader>f", group = "Format" },
  { "<leader>g", group = "Git" },
  { "<leader>i", group = "Quickfix" },
  { "<leader>k", group = "Claude commands" },
  { "<leader>l", group = "LSP & lists" },
  { "<leader>n", group = "Notes" },
  { "<leader>o", group = "Sticky terminals" },
  { "<leader>p", group = "Terminal splits & paste" },
  { "<leader>r", group = "Replace" },
  { "<leader>s", group = "Spelling, session & swap" },
  { "<leader>t", group = "Telescope & tabs" },
  { "<leader>u", group = "Toggle UI" },
  { "<leader>v", group = "Nvim config" },
  { "<leader>w", group = "Wolverine & debug logs" },
  { "<leader>x", group = "Conflicts & diagnostics" },
  { "<leader>z", group = "Center window" },

  -- nested groups
  { "<leader>oc", group = "Toggle Claude terminal" },
  { "<leader>oC", group = "New Claude terminal" },
  { "<leader>tc", group = "Claude artifacts" },
  { "<leader>vp", group = "Installed plugins" },

  -- diagnostic motions, both on the AZERTY and the US positions
  { "<leader>(", group = "Previous diagnostic" },
  { "<leader>[", group = "Previous diagnostic" },
  { "<leader>)", group = "Next diagnostic" },
  { "<leader>]", group = "Next diagnostic" },
}

-- <leader>c aliases across keyboard layouts, and <leader>g1..g9 diff bases
for _, alias in ipairs({ '"', "#", "3" }) do
  table.insert(groups, { "<leader>" .. alias, group = ".NET" })
end
for n = 1, 9 do
  table.insert(groups, { "<leader>g" .. n, group = "Diff base HEAD~" .. n })
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    -- ours win, then upstream's, then a catch-all so every desc gets something.
    -- Upstream rules must be inlined here: which-key stops at the first match in
    -- `icons.rules`, so a catch-all placed there would otherwise shadow them.
    local merged = vim.list_extend(vim.deepcopy(rules), require("which-key.icons").rules)
    table.insert(merged, { pattern = ".", icon = "󰌌 ", color = "grey" })

    local wk = require("which-key")
    wk.setup({
      preset = "helix",
      delay = 300,
      icons = { rules = merged },
    })

    wk.add(groups)

    local visual_groups = vim.tbl_map(function(g)
      return vim.tbl_extend("force", vim.deepcopy(g), { mode = "v" })
    end, vim.tbl_filter(function(g)
      return vim.tbl_contains({ "<leader>a", "<leader>f", "<leader>g", "<leader>r", "<leader>t" }, g[1])
    end, groups))

    wk.add(visual_groups)
  end,
}
