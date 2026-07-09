require 'utils'

local M = {}

function M.setup()
  vim.pack.add {
    {
      src = gh 'stevearc/oil.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
  }

  require('oil').setup {
    default_file_explorer = true,

    columns = {
      'icon',
    },

    view_options = {
      show_hidden = true,
      natural_order = true,
      is_always_hidden = function(name, _) return name == '..' or name == '.git' end,
    },

    win_options = {
      signcolumn = 'no',
      number = false,
      wrap = true,
    },

    keymaps = {
      ['<C-c>'] = 'actions.close',
      ['<CR>'] = 'actions.select',
      ['-'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['g.'] = 'actions.toggle_hidden',
    },

    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,
  }
end

return M
