local utils = require('config/utils')

Snacks.toggle.option("spell", {
  name = "Spelling"
}):map("<leader>uz")

Snacks.toggle.diagnostics():map("<leader>ud")

Snacks.toggle.new({
  id = "number",
  name = "Toggle number",
  get = function()
    return vim.wo[0].statuscolumn == "%l"
  end,
  set = function(set_nb)
    vim.notify(set_nb)
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
  id = "number",
  name = "Toggle absolute number",
  get = function()
    return vim.wo[0].relativenumber == false
  end,
  set = function(set_absolute)
    vim.wo[0].relativenumber = set_absolute
  end,
}):map("<leader>uN")


Snacks.toggle.new({
  id = "sign",
  name = "Toggle sign",
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
