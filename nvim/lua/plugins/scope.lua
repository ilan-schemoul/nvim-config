-- Plugin so buffers are local to tab
return {
    "tiagovla/scope.nvim",
    event = { "NormalBufferEnter" },
    config = function()
      -- So mksession saves plugin's data too
      require("scope").setup()
    end,
}

