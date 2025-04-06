return {
  "ravitemer/mcphub.nvim",
  cmd = { "MCPHub" },
  build = "bundled_build.lua",  -- Bundles mcp-hub locally
  opts = {
    config = vim.fn.expand("~/mcpservers.json"),  -- Absolute path to config file
    use_bundled_binary = true,  -- Use local binary
    extensions = {
      codecompanion = {
        -- Show the mcp tool result in the chat buffer
        -- NOTE:if the result is markdown with headers, content after the headers wont be sent by codecompanion
        show_result_in_chat = true,
        make_vars = true, -- make chat #variables from MCP server resources
        make_slash_commands = true, -- make /slash_commands from MCP server prompts
      },
    },
  },
}
