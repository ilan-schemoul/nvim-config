return {
  -- Hide color column when I don't do more than 78
  "m4xshen/smartcolumn.nvim",
  enabled = require("config/utils").is_intersec,
  opts = {
    custom_colorcolumn = {
      {
        cpp = "78",
        c = "78",
        python = "78",
        asciidoc = "78",
        iop = "78",
        d = "78",
        json = "78",
      },
    },
  },
}
