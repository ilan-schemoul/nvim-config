return {
  "ilan-schemoul/dashboard-nvim",

  event = "VimEnter",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dashboard",
      callback = function()
        require("plenary.curl").get("wttr.in/Paris?format=1", {
          callback = vim.schedule_wrap(function(response)
            if response.status == 200 then
              local body = response.body:gsub('%s+', "\\ ")
              vim.cmd("DashboardUpdateFooter \\  " .. body)
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
            -- footer = { "", "Loading...", "deded", "dede" },
          },
        })
      end,
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
