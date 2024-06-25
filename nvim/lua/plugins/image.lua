return {
  "3rd/image.nvim",
  -- Also need magic on the system (sudo apt install libmagickwand-dev)
  -- Does not currently work on windows terminal so disabled
  enabled = os.getenv("WSL_DISTRO_NAME") == nil and vim.fn.filereadable("/usr/include/ImageMagick-6/wand/MagickWand.h"),
  dependencies = {
    "leafo/magick",
    {
      -- To install lua rock which install lua packages
      "vhyrro/luarocks.nvim",
      priority = 1001, -- this plugin needs to run before anything else
      opts = {
        -- magick FFI to use the magic of the system
        rocks = { "magick" },
      },
    },
  },
  opts = {
    -- Kitty protocol is better but mostly supported by kitty
    -- ueberzug supports a ton of protocol (on linux) but is slower
    backend = os.getenv("KITTY_WINDOW_ID") ~= nil and "kitty" or "ueberzug",
  },
}

