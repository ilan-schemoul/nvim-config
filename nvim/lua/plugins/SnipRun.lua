return {
  "michaelb/sniprun",
  build = 'bash install.sh',
  cmd = { "SnipRun", "SnipInfo", "SnipReset", "SnipReplMemoryClean", "SnipClose", "SnipLive" },
  opts = {
    live_mode_toggle='enable',
    live_display = { "VirtualTextOk" } --..or anything you wantk
  },
  keys = {
    { ",X", "<Plug>SnipRun", mode = "n" },
    { ",X", "<Plug>SnipRun", mode = "v" },
    { ",Z", "<cmd>SnipClose<cr>" }
  }
}
