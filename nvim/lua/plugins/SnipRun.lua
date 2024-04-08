return {
  "michaelb/sniprun",
  build = "bash install.sh",
  cmd = { "SnipRun", "SnipInfo", "SnipReset", "SnipReplMemoryClean", "SnipClose", "SnipLive" },
  opts = {
    live_mode_toggle = "enable",
    live_display = { "VirtualTextOk" }, --..or anything you wantk
  },
  keys = {
    { "<leader>X", "<Plug>SnipRun", mode = "n" },
    { "<leader>X", "<Plug>SnipRun", mode = "v" },
    { "<leader>Z", "<cmd>SnipClose<cr>" },
  },
}
