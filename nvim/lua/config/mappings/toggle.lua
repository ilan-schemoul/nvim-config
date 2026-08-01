local utils = require('config/utils')

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
    return vim.wo[0].statuscolumn == "%l"
  end,
  set = function(set_nb)
    if set_nb then
      vim.wo[0].statuscolumn = "%l"
      vim.wo[0].number = true
      vim.wo[0].relativenumber = true
    else
      utils.setup_separators()
      vim.wo[0].number = false
      vim.wo[0].relativenumber = false
    end
  end,
}):map("<leader>un")

Snacks.toggle.new({
  id = "absolute_number",
  name = "Absolute number",
  get = function()
    return vim.wo[0].relativenumber == false and vim.wo[0].statuscolumn == "%l"
  end,
  set = function(absolute_nb)
    vim.wo[0].statuscolumn = absolute_nb and "%l" or utils.separator_char
    vim.wo[0].number = absolute_nb
    vim.wo[0].relativenumber = not absolute_nb
  end,
}):map("<leader>ua")

Snacks.toggle.new({
  id = "sign",
  name = "Sign",
  get = function()
    return vim.wo[0].statuscolumn == utils.separator_char
  end,
  set = function(set_sign)
    if set_sign then
      vim.wo[0].statuscolumn = utils.separator_char
    else
      vim.wo[0].statuscolumn = ""
      vim.wo[0].number = false
      vim.wo[0].relativenumber = false
    end
  end,
}):map("<leader>us")

Snacks.toggle.new({
  id = "markview",
  name = "Markview",
  get = require("markview.state").enabled,
  set = function(_)
    vim.cmd("Markview")
  end,
}):map("<leader>um")
