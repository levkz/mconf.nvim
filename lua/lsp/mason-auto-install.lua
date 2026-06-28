do
  vim.pack.add { gh 'WhoIsSethDaniel/mason-tool-installer.nvim' }

  -- Automatically install mason packages when editing a filetype
  -- require('mason-tool-installer').setup {
  --   packages = {
  --     'lua-language-server',
  --     'stylua',
  --     'goimports',
  --     'gopls',
  --     'rust-analyzer',
  --     'pyright',
  --     'ruff',
  --     'black',
  --     'typescript-language-server',
  --     'eslint-lsp',
  --     'prettierd',
  --     'prettier',
  --     'markdownlint',
  --   },
  -- }
end
