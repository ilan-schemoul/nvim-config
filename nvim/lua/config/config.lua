-- Read file in config.json root of config folder
local json_content = vim.fn.readfile(vim.fn.stdpath("config") .. "/config.json")
return vim.json.decode(table.concat(json_content, "\n"))
