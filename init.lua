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


require("bufferline").setup{
        options = {
                offsets = {
                        {
                                filetype = "NvimTree",
                                text = "File Explorer",
                                highlight = "Directory",
                                separator = true -- use a "true" to enable the default, or set your own character
                        }
                },
                numbers = "ordinal"
        -- mode = "tabs"
        },
}

vim.opt_local.suffixesadd:prepend('.lua')
vim.opt_local.suffixesadd:prepend('init.lua')
vim.opt_local.path:prepend(vim.fn.stdpath('config')..'/lua')

local opts = { silent = true }
-- Resize with arrows
vim.keymap.set("n","<leader>1","<Cmd>BufferLineGoToBuffer 1<CR>", opts)
vim.keymap.set("n","<leader>2","<Cmd>BufferLineGoToBuffer 2<CR>", opts)
vim.keymap.set("n","<leader>3","<Cmd>BufferLineGoToBuffer 3<CR>", opts)
vim.keymap.set("n","<leader>4","<Cmd>BufferLineGoToBuffer 4<CR>", opts)
vim.keymap.set("n","<leader>5","<Cmd>BufferLineGoToBuffer 5<CR>", opts)
vim.keymap.set("n","<leader>6","<Cmd>BufferLineGoToBuffer 6<CR>", opts)
vim.keymap.set("n","<leader>7","<Cmd>BufferLineGoToBuffer 7<CR>", opts)
vim.keymap.set("n","<leader>8","<Cmd>BufferLineGoToBuffer 8<CR>", opts)
vim.keymap.set("n","<leader>9","<Cmd>BufferLineGoToBuffer 9<CR>", opts)
vim.keymap.set("n","<leader>$","<Cmd>BufferLineGoToBuffer -1<CR>", opts)

