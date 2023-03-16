require "user.plugins"
require "user.options"
require "user.keymaps"
require "user.vimwiki"
require "user.comment"
require "user.auto-save"
require "user.indent_blankline"
require "user.nvim-autopairs"
require "user.telescope"
require "user.tree-sitter"
require "user.nvim-tree"
require "user.lualine"
require "user.toggle-term"
require "user.nvim-dap"
require "user.lsp"

vim.opt_local.suffixesadd:prepend('.lua')
vim.opt_local.suffixesadd:prepend('init.lua')
vim.opt_local.path:prepend(vim.fn.stdpath('config')..'/lua')
