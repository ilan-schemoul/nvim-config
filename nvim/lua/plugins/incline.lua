return {
  "b0o/incline.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    highlight = {
      groups = {
        InclineNormal = {
          default = true,
          group = "none"
        },
        InclineNormalNC = {
          default = true,
          group = "none"
        }
      }
    },
    window = {
      margin = {
        horizontal = 0,
        vertical = 0,
      },
      padding = 0,
      placement = {
        vertical = "bottom",
        horizontal = "right",
      },
    },
     render = function(props)
        local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":.")

        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(path)
        local modified = vim.bo[props.buf].modified and 'bold,italic' or 'bold'

        local function get_git_diff()
          local icons = { removed = "-", modified = "~", changed = "!=", added = "+" }
          local highlights = {
            removed = "GitSignsDelete",
            modified = "GitSignsChange",
            changed = "GitSignsChange",
            added = "GitSignsAdd"
          }
          local signs = vim.b[props.buf].gitsigns_status_dict
          local labels = {}
          if signs == nil then return labels end
          for name, icon in pairs(icons) do
            if tonumber(signs[name]) and signs[name] > 0 then
              table.insert(labels, { icon .. signs[name] .. " ", group = highlights[name] })
            end
          end
          if #labels > 0 then table.insert(labels, { "┊ " }) end
          return labels
        end
        local function get_diagnostic_label() -- de
          local icons = { error = '', warn = '', info = '', hint = '', }
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(
              props.buf,
              { severity = vim.diagnostic.severity[string.upper(severity)] }
            )
            if n > 0 then
              table.insert(label, { n .. icon .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          if #label > 0 then table.insert(label, { "┊ " }) end
          return label
        end

        local buffer = {
          { get_diagnostic_label() },
          { get_git_diff() },
          { (ft_icon or "") .. "", guifg = ft_color, guibg = "none" },
          { path .. "", gui = modified },
        }
        return buffer
    end,
  }
}

