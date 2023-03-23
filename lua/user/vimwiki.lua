-- conf vimwiki
vim.g.vimwiki_list = { { path = '~/Notes', syntax = 'markdown', ext = '.md',
  custom_wiki2html = '~/.local/share/nvim/site/pack/packer/start/vimwiki/autoload/vimwiki/customwiki2html.sh' } }
vim.g.vimwiki_ext2syntax = { ['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown', }
vim.g.vimwiki_global_ext = 0

vim.api.nvim_command('autocmd BufWinEnter *.md set syntax=markdown')
-- vim.api.nvim_command('autocmd BufRead,BufNewFile *.md set syntax=markdown')
vim.g.markdown_fenced_languages = {'html', 'python', 'ruby', 'vim', 'javascript', 'js=javascript', 'json=javascript', 'bash'}

-- keymaps for creating vimwiki tables
vim.keymap.set('n','<leader>t2', '<cmd>VimwikiTable 2<cr>',{desc = '[t]able with [2] cols' })
vim.keymap.set('n','<leader>t3', '<cmd>VimwikiTable 3<cr>',{desc = '[t]able with [3] cols'})
vim.keymap.set('n','<leader>t4', '<cmd>VimwikiTable 4<cr>',{desc = '[t]able with [4] cols'})



