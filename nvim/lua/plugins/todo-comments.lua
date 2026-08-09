return {
  -- XXX: use this fork to "wrap" jump_next
  "ben-krieger/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "NormalBufferEnter",
  keys = {
    { ")t", function() require("todo-comments").jump_next({keywords = { "TODO" }}) end, desc = "Next todo comment" },
    { "(t", function() require("todo-comments").jump_prev({keywords = { "TODO" }}) end, desc = "Previous todo comment" },
    { "]t", function() require("todo-comments").jump_next({keywords = { "TODO" }}) end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev({keywords = { "TODO" }}) end, desc = "Previous todo comment" },
  },
  opts = {
    sign_priority = 5, -- sign priority
    search = {
      wrap = true,
    },
  }
}
