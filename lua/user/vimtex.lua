-- Enable filetype plugins and indent
vim.cmd('filetype plugin indent on')

-- Enable syntax highlighting
vim.cmd('syntax enable')

-- Configure the viewer method
vim.g.vimtex_view_method = 'zathura'

-- Configure the generic viewer interface
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'

-- Configure the compiler method
-- vim.g.vimtex_compiler_latexmk_engines = 'lualatex'
vim.g.vimtex_compiler_method = 'latexmk'

-- vim.g.vimtex_compiler_latexmk_engines = {
--   _default = 'lualatex', -- Specify the default engine
--   -- pdflatex = 'lualatex',
--   -- lualatex = 'lualatex',
--   -- xelatex = 'xelatex',
--   -- Add more engines if desired
-- }
-- Configure the localleader
vim.g.maplocalleader = ","
