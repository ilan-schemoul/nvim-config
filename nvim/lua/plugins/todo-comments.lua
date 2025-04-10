return {
  -- XXX: use this fork to "wrap" jump_next
  "ben-krieger/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "LazyFile",
  keys = {
    { "]t", function() require("todo-comments").jump_next({keywords = { "TODO" }}) end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev({keywords = { "TODO" }}) end, desc = "Previous todo comment" },
  },
  opts = {
    search = {
      wrap = true,
    },
  }
}
