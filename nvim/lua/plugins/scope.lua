-- Plugin so buffers are local to tab
return {
    "tiagovla/scope.nvim",
    config = function()
      -- So mksession saves plugin's data too
      require("scope").setup()
      require("telescope").load_extension("scope")
    end,
}

