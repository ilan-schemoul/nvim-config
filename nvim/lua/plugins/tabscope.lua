-- Plugin so buffers are local to tab
return {
    "tiagovla/scope.nvim",
    init = function()
      -- So mksession saves plugin's data too
      
      require("telescope").load_extension("scope")
    end,
    event = "VimEnter",
    opts = {},
}

