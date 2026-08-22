return {
  "nvim-mini/mini.operators",
  opts = {
    -- Evaluate text and replace with output
    evaluate = {
      prefix = 'g=',

      -- Function which does the evaluation
      func = nil,
    },

    -- Exchange text regions
    exchange = {
      prefix = 'ge',

      -- Whether to reindent new text to match previous indent
      reindent_linewise = true,
    },

    -- Multiply (duplicate) text
    multiply = {
      prefix = 'gm',

      -- Function which can modify text before multiplying
      func = nil,
    },

    -- Replace text with register
    replace = {
      -- NOTE: Default `gr*` LSP mappings are removed
      prefix = 'gr',

      -- Whether to reindent new text to match previous indent
      reindent_linewise = true,
    },

    -- Sort text
    sort = {
      prefix = 'gs',

      -- Function which does the sort
      func = nil,
    }
  },
}
