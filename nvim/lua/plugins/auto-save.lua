return {
  "0x00-ketsu/autosave.nvim",
  event = { "NormalBufferEnter" },
  opts = {
    enable = true,
    events = { "InsertLeave", "TextChanged" },
    prompt = {
      enable = false,
    },
    conditions = {
      exists = false,
      modifiable = true,
      filetype_is_not = { "behave_log", "oil" },
    },
    write_all_buffers = false,
    debounce_delay = 200,
    prompt_message = "",
  },
}
