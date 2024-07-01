return {
  -- To install lua rock which install lua packages
  "vhyrro/luarocks.nvim",
  lazy = true,
  priority = 1001, -- this plugin needs to run before anything else
  opts = {
    -- magick FFI to use the magic of the system
    rocks = { "magick" },
  },
}

