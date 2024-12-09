-- A plugin to illuminate words that are the same than the one under your cursor
return {
  "RRethy/vim-illuminate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Seriously who uses "configure" ?
    require('illuminate').configure({
      -- Disabled after X number of lines
      large_file_cutoff = 5000,
    })
    end
}
