-- sudo apt install python3.11
-- pipx install git+https://github.com/Davidyz/VectorCode --python python3.11
-- I can also install vectorcode[lsp] and vectorcode[lsp,mcp]
return {
  enabled = os.getenv("NVIM_AI_ENABLE") ~= nil,
  "Davidyz/VectorCode",
  cmd = "VectorCode",
  version = "*", -- optional, depending on whether you're on nightly or release
  build = "pipx upgrade vectorcode", -- optional but recommended if you set `version = "*"`
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    n_query = 3,
    async_opts = {
      n_query = 3,
    }
  },
}
