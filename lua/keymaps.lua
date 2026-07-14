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
  -- vim.diagnostic.config {
  --   update_in_insert = false,
  --   severity_sort = true,
  --   float = { border = 'rounded', source = 'if_many' },
  --   underline = { severity = { min = vim.diagnostic.severity.WARN } },
  --
  --   -- Can switch between these as you prefer
  --   virtual_text = false, -- Text shows up at the end of the line
  --   virtual_lines = false, -- Text shows up underneath the line, with virtual lines
  --
  --   -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  --   jump = {
  --     on_jump = function(_, bufnr)
  --       vim.diagnostic.open_float {
  --         bufnr = bufnr,
  --         scope = 'cursor',
  --         focus = false,
  --       }
  --     end,
  --   },
  -- }

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

  -- Trouble / diagnostics
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = 1, float = true } end, {
    desc = 'Next diagnostic',
  })

  vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = -1, float = true } end, {
    desc = 'Previous diagnostic',
  })

  vim.keymap.set('n', '<leader>td', require('custom.plugins.diaz').toggle, {
    desc = '[T]oggle [D]iagnostic hover',
  })

  vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', {
    desc = 'Diagnostics (Trouble)',
  })

  vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', {
    desc = 'Buffer Diagnostics (Trouble)',
  })

  vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<CR>', {
    desc = 'Symbols (Trouble)',
  })

  vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<CR>', {
    desc = 'LSP Definitions/References',
  })

  vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<CR>', {
    desc = 'Location List',
  })

  vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<CR>', {
    desc = 'Quickfix List',
  })

  -- Oil
  vim.keymap.set('n', '<leader>e', require('oil').open, { desc = '[e]xplore' })

  -- Terminal
  vim.keymap.set('n', '<leader>st', require('custom.plugins.terminal').open, { desc = '[s]tart [t]erminal session' })

  -- Telescope

  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'delete and [p]aste while saving the previous last registry' })
  vim.keymap.set(
    'n',
    '<leader><leader>',
    function()
      builtin.buffers {
        sort_mru = true,
        ignore_current_buffer = true,
      }
    end,
    { desc = 'Find existing buffers' }
  )

  -- Harpoon
  local harpoon = require 'harpoon'

  vim.keymap.set('n', '<leader>ma', function() harpoon:list():add() end, { desc = '[M]ark [A]dd file' })
  vim.keymap.set('n', '<leader>md', function() harpoon:list():remove() end, { desc = '[M]ark [D]elete' })
  vim.keymap.set('n', '<leader>mm', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = '[M]ark [M]enu' })

  vim.keymap.set('n', '<leader>mn', function() harpoon:list():next() end, { desc = '[M]ark [N]ext' })

  vim.keymap.set('n', '<leader>mp', function() harpoon:list():prev() end, { desc = '[M]ark [P]revious' })

  for i = 1, 5 do
    vim.keymap.set('n', '<leader>m' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon ' .. i })
  end

  -- Format
  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })

  -- Git
  local gs = require 'gitsigns'
  vim.keymap.set('n', ']h', function() gs.nav_hunk 'next' end, { desc = '<]>Next git[h]unk' })
  vim.keymap.set('n', '[h', function() gs.nav_hunk 'prev' end, { desc = '<[>Previus git[h]unk' })

  vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { desc = 'git[h]unk [s]tage' })
  vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = 'git[h]unk [r]eset' })
  vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = 'git[h]unk [p]review' })
  vim.keymap.set('n', '<leader>hb', gs.blame_line, { desc = 'git[h]unk [b]lame' })
  vim.keymap.set('n', '<leader>hd', gs.diffthis, { desc = 'git[h]unk [d]iff' })
end

return M
