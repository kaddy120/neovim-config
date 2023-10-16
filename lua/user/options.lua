-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- highllight the cursor (current) line
vim.o.cursorline = true

-- convert tab to space
vim.o.expandtab = true
vim.o.tabstop = 1

vim.o.textwidth = 80
--[[ vim.o.colorcolumn=80 ]]

-- set relativenumber
--vim.wo.number = true
vim.wo.relativenumber = true


-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Change the splitv and splith open layou-- Change the splitv and splith open layoutt
vim.o.splitbelow = true;
vim.o.splitright = true;

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- vim.cmd("set spell spelllang=en_us") 
vim.cmd("set directory=$HOME/.vim/tmp")
vim.api.nvim_command('autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us')
vim.wo.linebreak = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
-- vim.cmd [[colorscheme onedark]]
vim.cmd [[colorscheme vscode]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Copy to clipboard
vim.keymap.set({ 'n', 'x' }, 'cp', '"+y')

-- Paste from clipboard
vim.keymap.set({ 'n', 'x' }, 'cv', '"+p')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- enable :GBrowser to open a browser
vim.cmd("command! -nargs=1 Browse silent execute '!open' shellescape(<q-args>,1)")

-- support // and * comment for *.json file
vim.api.nvim_command('autocmd BufRead,BufNewFile *.json set filetype=jsonc')

-- prevent starting a new line with a comment
-- vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
-- vim.api.nvim_command('autocmd BufEnter * vim.opt_local.formatoptions:remove({ "c", "r", "o" })')
-- Add this to your init.lua file

vim.cmd([[
  augroup RemoveFormatOptions
    autocmd!
    autocmd BufEnter * lua vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
  augroup END
]])


vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
  pattern = '.env*',
  command = 'set filetype=conf',
})
