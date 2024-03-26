return {
  {
    "ilan-schemoul/coq_nvim",
    dependencies = {
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" },
    },
    event = { "BufReadPre", "BufNewFile" },
  },
}
