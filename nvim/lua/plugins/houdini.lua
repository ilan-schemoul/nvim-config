return {
  "ilan-schemoul/houdini.nvim",
  opts = {
    excluded_filetypes = { "lazygit" },
    escape_sequences = {
        ['i']    = '<BS><BS><ESC>',        -- insert mode
        ['ic']   = '<BS><BS><ESC>',
        ['ix']   = '<BS><BS><ESC>',

        ['t'] = '<BS><BS><C-\\><C-n>', -- terminal mode
        ['c'] = '<BS><BS><C-c>',       -- command line mode

        ['R']    = '', -- replace mode
        ['Rc']   = '',
        ['Rx']   = '',
        ['Rv']   = '', -- virtual replace mode
        ['Rvc']  = '',
        ['Rvx']  = '',
        ['v']    = function() end,      -- visual mode
        ['vs']   = function() end,
        ['V']    = function() end,
        ['Vs']   = function() end,
        ['']   = function() end,
        ['s']  = function() end,
        ['no']   = function() end,      -- operator mode
        ['nov']  = function() end,
        ['noV']  = function() end,
        ['no'] = function() end,

        ['s']  = '',
        ['S']  = '',
        [''] = '',

        -- this is obviously a "hack" and will not work with inputs longer than 100 characters, but it should cover the majority of cases in Ex mode
        ['cv']  = '',
      },
  },
}

