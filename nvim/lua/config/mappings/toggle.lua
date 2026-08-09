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
    if set_nb then
      vim.wo[0].signcolumn = "no"
      vim.wo[0].statuscolumn = "%l"
      vim.wo[0].relativenumber = true
    else
      vim.wo[0].signcolumn = "yes:1"
      vim.wo[0].statuscolumn = "%s"
      vim.wo[0].relativenumber = false
      vim.wo[0].number = false
    end
  end,
}):map("<leader>ur")

Snacks.toggle.new({
  id = "absolute_number",
  name = "Absolute number",
  get = function()
    return vim.wo[0].relativenumber == false and vim.wo[0].statuscolumn == "%l"
  end,
  set = function(absolute_nb)
    vim.wo[0].statuscolumn = absolute_nb and "%l" or "%s"
    vim.wo[0].signcolumn = absolute_nb and "no" or "yes:1"
    vim.wo[0].number = absolute_nb
    vim.wo[0].relativenumber = false
  end,
}):map("<leader>ua")

Snacks.toggle.new({
  id = "sign",
  name = "Sign",
  get = function()
    return vim.wo[0].statuscolumn == "%s"
  end,
  set = function(set_sign)
    vim.wo[0].relativenumber = false
    vim.wo[0].number = false

    if set_sign then
      vim.wo[0].statuscolumn = "%s"
      vim.wo[0].signcolumn = "yes:1"
    else
      vim.wo[0].statuscolumn = ""
      vim.wo[0].signcolumn = "no"
    end
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
    if enabled then
      require("rainbow-delimiters").enable(0)
    else
      require("rainbow-delimiters").disable(0)
    end
  end,
}):map("<leader>ug")

--
