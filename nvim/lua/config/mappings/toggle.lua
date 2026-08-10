local api = require('config/api')

Snacks.toggle.option("spell", {
  name = "Spelling"
}):map("<leader>uz")

Snacks.toggle.diagnostics():map("<leader>ud")

Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")

Snacks.toggle.treesitter():map("<leader>ut")
Snacks.toggle.indent():map("<leader>ui")
Snacks.toggle.dim():map("<leader>uD")

Snacks.toggle.new({
  id = "number",
  name = "Number",
  get = function()
    return vim.wo[0].statuscolumn == "%l" and vim.wo[0].relativenumber == true
  end,
  set = function(set_nb)
    api.status_column.set_number_signcolumn(set_nb)

    vim.wo[0].number = set_nb
    vim.wo[0].relativenumber = set_nb
  end,
}):map("<leader>ur")

Snacks.toggle.new({
  id = "absolute_number",
  name = "Absolute number",
  get = function()
    return vim.wo[0].statuscolumn == "%l" and vim.wo[0].relativenumber == false
  end,
  set = function(absolute_nb)
    api.status_column.set_number_signcolumn(absolute_nb)

    vim.wo[0].number = absolute_nb
    vim.wo[0].relativenumber = not absolute_nb
  end,
}):map("<leader>ua")

Snacks.toggle.new({
  id = "sign",
  name = "Sign",
  get = function()
    return vim.wo[0].statuscolumn ~= ""
  end,
  set = function(set_sign)
    api.status_column.set_signcolumn(set_sign)

    vim.wo[0].number = false
    vim.wo[0].relativenumber = false
  end,
}):map("<leader>us")

Snacks.toggle.new({
  id = "markview",
  name = "Markview",
  get = function()
    require("markview.state").enabled()
  end,
  set = function(_)
    vim.cmd("Markview")
  end,
}):map("<leader>um")

Snacks.toggle.new({
  id = "rainbow_delimiters",
  name = "Rainbow Delimiters",
  get = function()
    return require("rainbow-delimiters").is_enabled(0)
  end,
  set = function(enabled)
    local rainbow = require("rainbow-delimiters")

    rainbow.enable(0)

    if enabled then
      rainbow.enable(0)
    else
      rainbow.disable(0)
    end
  end,
}):map("<leader>ug")

Snacks.toggle.new({
  id = "colorcolumn",
  name = "Color column",
  get = function()
    return vim.wo[0].colorcolumn ~= "0"
  end,
  set = function(set_cc)
    if set_cc then
      -- Force smart column refresh
      vim.b[0].prev_state = false
      vim.api.nvim_exec_autocmds("CursorMoved", { buffer = 0 })
    else
      vim.wo[0].colorcolumn = "0"
    end
  end,
}):map("<leader>uc")

