return {
  "ravitemer/mcphub.nvim",
  cmd = { "MCPHub" },
  opts = {
    port = 3000,  -- Port for MCP Hub server
    config = vim.fn.expand("~/mcpservers.json"),  -- Absolute path to config file
  },
}
