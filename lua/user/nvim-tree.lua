vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup()

-- Toggle NvimTree
vim.keymap.set({ 'n', 'i', 't' }, '<C-b>', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle NvimTree' })
