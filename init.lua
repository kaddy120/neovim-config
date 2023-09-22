require "user.plugins"
require "user.vimtex"
require "user.options"
require "user.keymaps"
require "user.vimwiki"
require "user.comment"
require "user.indent_blankline"
require "user.nvim-autopairs"
require "user.telescope"
require "user.tree-sitter"
require "user.nvim-tree"
require "user.lualine"
require "user.toggle-term"
require "user.nvim-dap"
require "user.lsp"
require "user.vscodeTheme"
require "user.trouble"
require "user.null-ls"
require "user.colorizer"
require "user.bufferline"
require "user.nvim-cmp"
require "user.ufo"
require "user.gitsigns"

vim.opt_local.suffixesadd:prepend('.lua')
vim.opt_local.suffixesadd:prepend('init.lua')
vim.opt_local.path:prepend(vim.fn.stdpath('config') .. '/lua')

