return {
  "stevearc/dressing.nvim",
  opts = {
    select = {
      backend = { "nui" },
      get_config = function(opts)
        if opts.kind == "codeaction" then
          return {
            nui = {
              position = {
                col = 0,
                row = 2,
              },
              backend = "nui",
              relative = "cursor",
            },
          }
        end
      end,
    },
  },
}
