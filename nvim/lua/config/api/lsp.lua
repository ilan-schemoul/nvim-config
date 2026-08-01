local M = {}

-- Rename, then write every buffer once the LSP is done applying the edits
M.rename = function()
  vim.lsp.buf.rename()

  local id
  id = vim.api.nvim_create_autocmd("LspRequest", {
    callback = function(ev)
      local request = ev.data.request
      if request.method ~= "textDocument/rename" or request.type ~= "complete" then return end

      vim.schedule(function()
        vim.cmd('silent! wa')
      end)

      vim.api.nvim_del_autocmd(id)
    end,
  })
end

return M
