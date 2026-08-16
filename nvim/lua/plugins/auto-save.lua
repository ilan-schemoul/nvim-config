return {
  "ilan-schemoul/autosave.nvim",
  event = { "NormalBufferEnter" },
  config = function(_, opts)
    require('autosave').setup(opts)

    require('autosave').hook_before_saving = function ()
      -- vim.g.auto_save_abort = require('diffbandit').is_running()
    end
  end,
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
