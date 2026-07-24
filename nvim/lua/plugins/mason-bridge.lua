-- Useful to use mason binaries with linters and formater (conform)
return {
  "frostplexx/mason-bridge.nvim",
  event = "NormalBufferEnter",
  dependencies = {
    "williamboman/mason.nvim",
  },
  opts = {},
}

