local M = {}

function M.setup()
  vim.pack.add { gh 'folke/trouble.nvim' }

  require('trouble').setup {}
end

return M
