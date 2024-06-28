return {
  "3rd/image.nvim",
  -- Also need magic on the system (sudo apt install libmagickwand-dev)
  -- Does not currently work on windows terminal so disabled
  enabled = os.getenv("WSL_DISTRO_NAME") == nil and vim.fn.filereadable("/usr/include/ImageMagick-6/wand/MagickWand.h"),
  dependencies = {
    "leafo/magick",
    "vhyrro/luarocks.nvim",
  },
  opts = {
    -- Kitty protocol is better but mostly supported by kitty
    -- ueberzug supports a ton of protocol (on linux) but is slower
    backend = os.getenv("KITTY_WINDOW_ID") ~= nil and "kitty" or "ueberzug",
  },
}

