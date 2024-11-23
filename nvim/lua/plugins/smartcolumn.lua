return {
  -- Hide color column when I don't do more than 78
  "m4xshen/smartcolumn.nvim",
  enabled = require("config/utils").is_intersec,
  opts = {
    colorcolumn = "78", -- Only relevant for Intersec
  },
}
