return {
  { filter = { find = "No information available" }, opts = { stop = true } },
  { filter = { find = "fewer lines;" }, opts = { skip = true } },
  { filter = { find = "more line;" }, opts = { skip = true } },
  { filter = { find = "more lines;" }, opts = { skip = true } },
  { filter = { find = "less;" }, opts = { skip = true } },
  { filter = { find = "Already at newest" }, view = "mini" },
  { filter = { find = "Already at oldest" }, view = "mini" },
  { filter = { find = "TeeSave" }, view = "mini" },
  { filter = { find = "change;" }, opts = { skip = true } },
  { filter = { find = "changes;" }, opts = { skip = true } },
  { filter = { find = "indent" }, opts = { skip = true } },
  { filter = { find = "move" }, opts = { skip = true } },

  -- Disable "file_path" AMOUNT_OF_LINESL, AMOUNT_OF_BYTESB message
  { filter = { event = "msg_show", kind = "", find = '"[%w%p]+" %d+L, %d+B' }, opts = { skip = true } },

  -- Disable "search messages"
  { filter = { event = "msg_show", kind = "wmsg", find = "search hit BOTTOM, continuing at TOP", }, opts = { skip = true }, },
  { filter = { event = "msg_show", kind = "wmsg", find = "search hit TOP, continuing at BOTTOM" }, opts = { skip = true }, },

  -- Disable "redo/undo" messages
  { filter = { event = "msg_show", kind = "lua_error", find = "more line" }, opts = { skip = true } },
  { filter = { event = "msg_show", kind = "lua_error", find = "fewer line" }, opts = { skip = true } },
  { filter = { event = "msg_show", kind = "lua_error", find = "line less" }, opts = { skip = true } },
  { filter = { event = "msg_show", kind = "lua_error", find = "change;" }, opts = { skip = true } },
  { filter = { event = "msg_show", kind = "", find = "more line" }, opts = { skip = true } },
  { filter = { event = "msg_show", kind = "", find = "fewer line" }, opts = { skip = true } },
  { filter = { event = "msg_show", kind = "", find = "line less" }, opts = { skip = true } },
  { filter = { event = "msg_show", kind = "", find = "change;" }, opts = { skip = true } },
}
