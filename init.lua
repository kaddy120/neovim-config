 require "user.tree-sitter"
 require "user.plugins"
 require "user.vimtex"
 require "user.options"
 require "user.keymaps"
 require "user.vimwiki"
 require "user.indent_blankline"
 require "user.nvim-autopairs"
 require "user.telescope"
 require "user.lualine"
 require "user.toggle-term"
 require "user.nvim-dap"
 require "user.lsp"
 require "user.vscodeTheme"
 require "user.trouble"
 require "user.null-ls"
 require "user.colorizer"
 require "user.nvim-cmp"
 require "user.gitsigns"

require "user.nvim-tree"
require "user.comment"

vim.opt_local.suffixesadd:prepend('.lua')
vim.opt_local.suffixesadd:prepend('init.lua')
vim.opt_local.path:prepend(vim.fn.stdpath('config') .. '/lua')
vim.g.nvim_tree_gitignore = {'%.git$'}
