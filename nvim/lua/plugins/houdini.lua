return {
  "TheBlob42/houdini.nvim",
  opts = {
    mappings = { "hj" },
    excluded_filetypes = { "lazygit" },
    -- A plugin so hj can escape insert as well as terminal mode.
    -- Unlike some other methods there is no lagging associated to typing h.
    escape_sequences = {
        ['i']    = '<BS><BS><ESC>',        -- insert mode
        ['ic']   = '<BS><BS><ESC>',
        ['ix']   = '<BS><BS><ESC>',

        ['t'] = '<BS><BS><C-\\><C-n>', -- terminal mode

        -- NOTE: disable everything else
        ['c'] = '',       -- command line mode
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
        ['cv']  = '',
      },
  },
}

