return {
  "chrisgrieser/nvim-scissors",
  cmd = { "ScissorsAddNewSnippet", "ScissorsEditSnippet" },
  opts = {
    snippetDir = "~/.config/nvim/snippets",
    editSnippetPopup = {
      keymaps = {
        deleteSnippet = "<C-x>",
      },
    },
  },
}
