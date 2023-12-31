-- Keymap for opening init.lua
vim.keymap.set("n", "<Leader>rc", "<cmd>vsp $MYVIMRC<cr>", { desc = "Open luarc in vertical split" })

-- toggle ZenMode (focusMode)
vim.keymap.set("n", "<Leader>z", "<cmd>ZenMode<cr>", { desc = "Open luarc in vertical split" })

-- Keymaps for saving a file
vim.keymap.set("n", "<Space>w", "<cmd>write<cr>", { desc = "Save file" })
vim.keymap.set("n", "<Space>wq", "<cmd>wq<cr>", { desc = "Save file and exit file" })
vim.keymap.set("n", "<Space>Q", "<cmd>q!<cr>", { desc = "Exit file without saving" })

-- Keymaps for switching between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to the bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to the top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to the left window" })
-- Keymaps for creating window splits
vim.keymap.set("n", "<Leader>v", "<C-w>v", { desc = "Create vertical split" })
vim.keymap.set("n", "<Leader>h", "<C-w>s", { desc = "Create horizontal split" })
vim.keymap.set("n", "<Leader>cc", "<C-w>c", { desc = "Close window" })

local opts = { silent = true }
-- Resize with arrows
vim.keymap.set("n", "<C-A-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-A-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-A-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-A-Right>", ":vertical resize +2<CR>", opts)

vim.keymap.set("v", "p", '"_dP', opts)
-- keymap("v", "P", '"_dP', opts)

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "i" }, "jk", "<Esc>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<S-Right>", ":bnext<CR>", opts)
-- Navigate buffers
vim.keymap.set("n", "<S-Left>", ":bprevious<CR>", opts)

-- move half a page up and down, and position a cursor in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

vim.keymap.set("n", "<leader>T", "<Plug>PlenaryTestFile", opts)
vim.keymap.set("n", "<leader>xx", ":source %<CR>", opts)


-- Remap ` to '
vim.keymap.set('n', "'", '`', { noremap = true })
vim.keymap.set('v', "'", '`', { noremap = true })
vim.keymap.set('o', "'", '`', { noremap = true })

