return {
  "altermo/nwm",
  --libx11 is required
  enabled = require("config/utils").check_libXfixes,
  branch = "x11",
  opts = {},
}

