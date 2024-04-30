return {
  "embear/vim-localvimrc",
  enabled = function() return os.getenv("IS_INTERSEC") == "true" end, -- adjusts shiftwidth/expandtab based on other files
}
