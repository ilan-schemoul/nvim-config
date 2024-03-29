return {
  "ilan-schemoul/dashboard-nvim",
  event = "VimEnter",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dashboard",
      callback = function()
        require("plenary.curl").get("wttr.in/?format=1", {
          callback = vim.schedule_wrap(function(response)
            if response.status == 200 then
              vim.cmd("DashboardUpdateFooter " .. response.body)
            else
              vim.cmd("DashboardUpdateFooter")
              print("weather failed status is ", response.status)
            end
          end),
          on_error = vim.schedule_wrap(function(opts)
            print("curl weather failed " .. opts.message)
            vim.cmd("DashboardUpdateFooter")
          end),
        })

        require("dashboard").setup({
          theme = "hyper",
          shortcut_type = "number",
          config = {
            header = {},
            shortcut = {},
            footer = { "", "Loading..." },
          },
        })
      end,
    })
    vim.cmd("highlight DashboardFooter cterm=italic gui=italic guifg=#6e738d")
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
