-- ============================================================
-- SECTION 2: KEYMAPS
-- basic keymaps
-- ============================================================
local M = {}

function M.set()
  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  vim.keymap.set('n', '<leader>tt', vim.cmd.tabnew, { desc = '[t]ab [t]abnew' })
  vim.keymap.set('n', '<leader>tc', vim.cmd.tabclose, { desc = '[t]ab [c]lose' })
  vim.keymap.set('n', '<leader>tp', vim.cmd.tabp, { desc = '[t]ab [p]rev' })
  vim.keymap.set('n', '<leader>tn', vim.cmd.tabn, { desc = '[t]ab [n]ext' })
  vim.keymap.set('n', '<leader>t-', function() vim.cmd 'tabmove -' end, { desc = '[t]ab move [-]' })
  vim.keymap.set('n', '<leader>t+', function() vim.cmd 'tabmove +' end, { desc = '[t]ab move [+]' })
  vim.keymap.set('n', '<leader>tO', vim.cmd.tabonly, { desc = '[t]ab [O]nly' })
  vim.keymap.set('n', '<leader>tf', ':tabfind ', { desc = '[t]ab [f]ind <file>' })

  for i = 1, 9 do
    vim.keymap.set('n', '<leader>t' .. i, i .. 'gt')
  end

  vim.keymap.set('n', 'ss', vim.cmd.split, { desc = '[s]plit: [s]plit horizontal' })
  vim.keymap.set('n', 'sv', vim.cmd.vsplit, { desc = '[s]plit [v]ertical' })

  vim.keymap.set('n', 'sc', vim.cmd.close, { desc = '[s]plit [c]lose' })
  vim.keymap.set('n', 'so', vim.cmd.only, { desc = '[s]plit [o]nly' })

  vim.keymap.set('v', '>', '>gv', { desc = 'Indent and keep selection' })
  vim.keymap.set('v', '<', '<gv', { desc = 'Unindent and keep selection' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

return M
