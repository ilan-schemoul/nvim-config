local dap = require("dap")

-- for c/c++/rust (rust can be improved with https://github.com/simrat39/rust-tools.nvim/wiki/Debugging)
dap.adapters.codelldb = {
  type = "server",
  port = "2000",
  executable = {
    command = "/home/ilan/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
    args = { "--port", "2000" },

    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}
local codelldb_config = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.c = codelldb_config
dap.configurations.cpp = codelldb_config
dap.configurations.rust = codelldb_config
