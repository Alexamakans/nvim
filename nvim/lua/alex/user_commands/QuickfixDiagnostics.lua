local method = "textDocument/publishDiagnostics"
local default_callback = vim.lsp.handlers[method]

local locations = {}

vim.lsp.handlers[method] = function(err, method, result, client_id)
  default_callback(err, method, result, client_id)
  if result and result.diagnostics then
    local entries = {}
    for _, v in ipairs(result.diagnostics) do
      v.uri = v.uri or result.uri
      table.insert(entries, v)
    end
    locations = entries
  end
end

vim.api.nvim_create_user_command("QuickfixDiagnostics", function()
  vim.diagnostic.setqflist(locations)
end, {})
