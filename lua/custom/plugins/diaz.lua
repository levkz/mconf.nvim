local M = {}

local diagnostics_hover_enabled = true

function M.setup()
  vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
      if not diagnostics_hover_enabled then return end

      vim.diagnostic.open_float(nil, {
        focus = false,
        scope = 'cursor',
        border = 'rounded',
        source = 'if_many',
      })
    end,
  })
end

function M.toggle()
  diagnostics_hover_enabled = not diagnostics_hover_enabled
  vim.notify('Diagnostic hover ' .. (diagnostics_hover_enabled and 'enabled' or 'disabled'))
end

return M
