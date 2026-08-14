local api = require('config/api')

local keys = {
  { "mt", function() require("haunt.api").toggle_annotation() end, desc = "Toggle bookmark annotation" },
  { "mm", function() require("haunt.api").toggle_annotation() end, desc = "Toggle bookmark annotation" },
  { "mT", function() require("haunt.api").toggle_all_lines() end, desc = "Toggle all annotations" },
  { "mM", function() require("haunt.api").toggle_all_lines() end, desc = "Toggle all annotations" },
  { "mn", function() require("haunt.api").annotate() end, desc = "Annotate bookmark" },
  { "md", function() require("haunt.api").delete() end, desc = "Delete bookmark" },

  { "]m", function() require("haunt.api").next() end, desc = "Next bookmark" },
  { "[m", function() require("haunt.api").prev() end, desc = "Previous bookmark" },

  { "mc", function() require("haunt.api").clear() end, desc = "Clear bookmarks in file" },
  { "mC", function() require("haunt.api").clear_all() end, desc = "Clear all bookmarks" },

  -- List bookmarks
  { "ml", function() require("haunt.picker").show() end, desc = "List bookmarks" },

  { "mq", function() require("haunt.api").to_quickfix({ current_buffer = true }) end, desc = "File bookmarks to quickfix" },
  { "mQ", function() require("haunt.api").to_quickfix() end, desc = "All bookmarks to quickfix" },

  { "my", function() require("haunt.api").yank_locations({ current_buffer = true }) end, desc = "Send buffer's bookmarks to clipboard" },
  { "mY", function() require("haunt.api").yank_locations() end, desc = "Send all bookmarks to clipboard" },

  { "ms", api.claude.send_bookmarks, desc = "Send buffer's bookmarks to clipboard" },
  { "mS", api.claude.send_all_bookmarks, desc = "Send all bookmarks to clipboard" },
}

local original_count = #keys
for i = 1, original_count do
  local key = keys[i]
  table.insert(keys, { "<leader>" .. key[1], key[2], desc = key.desc })
end

local specs = {
  "TheNoeTrevino/haunt.nvim",
  opts = {
    picker = "telescope",
    picker_keys = {
      delete = { key = "<C-x>", mode = { "i" } },
      edit_annotation = { key = "<C-e>", mode = { "i" } },
    },
  },
  keys = keys,
}

return specs
