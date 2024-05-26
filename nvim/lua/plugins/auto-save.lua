return {
  "0x00-ketsu/autosave.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    enable = true,
    events = { "InsertLeave", "TextChanged" },
    conditions = {
      exists = false,
      modifiable = true,
      filename_is_not = { "behave_logs" },
    },
    write_all_buffers = false,
    debounce_delay = 135,
    prompt_message = "",
  },
}
