return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    local curl = require("plenary.curl")
    -- local ok, res = pcall(curl.get, "wttr.in/?format=1", { timeout = 150 })
    local weather = ""
    -- if ok and res.status == 200 then
    -- weather = res.body
    -- elseif not ok then
    -- vim.cmd("echom \"curl failed\"")
    -- else
    -- vim.cmd("echom " .. res.status)
    -- end
    require("dashboard").setup({
      theme = "hyper",
      config = {
        header = {},
        shortcut = {},
        footer = { "", weather },
      },
    })
    vim.cmd("highlight DashboardFooter cterm=italic gui=italic guifg=#6e738d")
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
