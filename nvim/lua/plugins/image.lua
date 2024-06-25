return {
  "3rd/image.nvim",
  enabled = os.getenv("KITTY_WINDOW_ID") ~= nil,
  dependencies = {
    "leafo/magick",
  },
  opts = {
    backend = "kitty",
  },
}

