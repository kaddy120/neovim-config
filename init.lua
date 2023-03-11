-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  use 'maxmellon/vim-jsx-pretty'
  --- replace (use "rstacruz/sparkup") with emmet-vim
  -- use 'mattn/emmet-vim'
  use 'rcarriga/nvim-notify' -- fency notification plugin
  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-signature-help' },
  }
  use "rafamadriz/friendly-snippets" -- VS-Code like snippet

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    -- run = ':TSInstall tsx',
    -- commit = '9bfaf62e42bdcd042df1230e9188487e62a112c0'
    -- run = function()
    --   pcall(require('nvim-treesitter.install').update { with_sync = true })
    -- end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use 'digitaltoad/vim-pug' -- add pug syntex supportu

  use 'mfussenegger/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use { "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"} }
  use {
    "microsoft/vscode-js-debug",
    opt = true,
    run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  }
  use { -- nvim-tree, alternative to a nerdTree
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use({
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  })

  -- Latex support
  use 'lervag/vimtex'
  use 'vimwiki/vimwiki'
  -- use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Floating terminal that is toggleable
  use "akinsho/toggleterm.nvim"

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  use "nvim-telescope/telescope-dap.nvim" -- use telescope to interface dap
  -- Fuzzy Finder (files, lsp, etc)
  use({
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.0",
    branch = "0.1.x",
    requires = { { "nvim-lua/plenary.nvim" }, { "HUAHUAI23/telescope-dapzzzz" } },
    config = function()
      require("telescope").setup({})
      require('telescope').load_extension("dap")
      require("telescope").load_extension("i23")
    end,
  })

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})


-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- highllight the cursor (current) line
vim.o.cursorline = true

-- convert tab to space
vim.o.expandtab = true


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
vim.cmd [[colorscheme onedark]]

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

-- Keymap for opening init.lua
vim.keymap.set('n', '<Leader>rc', '<cmd>vsp $MYVIMRC<cr>', { desc = 'Open luarc in vertical split' })
vim.keymap.set('n', '<Leader>z', '<cmd>ZenMode<cr>', { desc = 'Open luarc in vertical split' })


-- Keymaps for saving a file
vim.keymap.set('n', '<Space>w', '<cmd>write<cr>', { desc = 'Save file' })
vim.keymap.set('n', '<Space>wq', '<cmd>wq<cr>', { desc = 'Save file and exit file' })
vim.keymap.set('n', '<Space>Q', '<cmd>q!<cr>', { desc = 'Exit file without saving' })

-- Keymaps for switching between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to the bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to the top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to the left window' })

-- Toggle NvimTree
vim.keymap.set({ '', 'i', 't' }, '<C-b>', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle NvimTree' })


-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}

-- conf vimwiki
vim.g.vimwiki_list = { { path = '~/Notes', syntax = 'markdown', ext = '.md',
  custom_wiki2html = '~/.local/share/nvim/site/pack/packer/start/vimwiki/autoload/vimwiki/customwiki2html.sh' } }
vim.g.vimwiki_ext2syntax = { ['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown', }
vim.g.vimwiki_global_ext = 0

-- vim.api.nvim_command('autocmd BufLeave *.md mkview')
-- vim.api.nvim_command('autocmd BufReadPost *.md silent! loadview')
-- vim.api.nvim_command('autocmd BufWinLeave *.md mkview')

-- vim.api.nvim_command('autocmd FileType markdown BufWinLeave * mkview')
-- vim.api.nvim_command('autocmd FileType markdown BufWinEnter * silent! loadview')
-- vim.api.nvim_command('autocmd FileType markdown BufReadPost *.md silent! loadview')
-- vim.api.nvim_command('autocmd  BufWinEnter * lua print("Loading view for " .. vim.fn.expand("%"))')
-- Ensure that when line wraps it does not cut in the middle of a word
-- function loadview()
--   local viewfile = vim.fn.expand('%:p') .. '.view'
--   if vim.fn.filereadable(viewfile) == 1 then
--     vim.cmd('silent loadview ' .. viewfile)
--   end
-- end
-- vim.cmd('filetype plugin on')
-- Keymaps for creating tables  
vim.keymap.set('n','<leader>t2', '<cmd>VimwikiTable 2<cr>',{desc = '[t]able with [2] cols' })
vim.keymap.set('n','<leader>t3', '<cmd>VimwikiTable 3<cr>',{desc = '[t]able with [3] cols'})
vim.keymap.set('n','<leader>t4', '<cmd>VimwikiTable 4<cr>',{desc = '[t]able with [4] cols'})

-- vim.o.foldlevel = 99
-- vim.cmd('set foldenabled')
-- vim.cmd('au FileType markdown setlocal foldlevel=99')
-- vim.api.nvim_command('autocmd BufRead,BufNewFile *.md set foldmethod=syntax')
-- vim.o.foldmethod=syntax
-- Enable Comment.nvim
--
-- fold settings

--  folds are defined by a user-defined expression (tree-sitter)
-- vim.o.foldmethod = 'syntax'



-- Enable dap 

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

-- use nvim-dap events to open and close the windows automatically
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- set dap log levvel to Trace
dap.set_log_level('TRACE')

-- custom adapter for running tasks before starting debug
local custom_adapter = 'pwa-node-custom'
dap.adapters[custom_adapter] = function(cb, config)
  if config.preLaunchTask then
    local async = require('plenary.async')
    local notify = require('notify').async

    async.run(function()
      ---@diagnostic disable-next-line: missing-parameter
      notify('Running [' .. config.preLaunchTask .. ']').events.close()
    end, function()
        vim.fn.system(config.preLaunchTask)
        config.type = 'pwa-node'
        dap.run(config)
      end)
  end
end

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      name = "Launch file",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
      rootPath = "${workspaceFolder}",
      skipFiles = { '<node_internals>/**' },
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = "Attach",
      type = "pwa-node",
      request = "attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
      localRoot = "./",
      restart = true,
      resolveSourceMapLocations = {"${workspaceFolder}/**", "!**/node_modules/**"},
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      trace = true,
      protocol = 'insepector',
    },
    {
      name = 'Debug Main Process (Electron)',
      type = 'pwa-node',
      request = 'launch',
      program = '${workspaceFolder}/node_modules/.bin/electron',
      args = {
        '${workspaceFolder}/dist/index.js',
      },
      outFiles = {
        '${workspaceFolder}/dist/*.js',
      },
      resolveSourceMapLocations = {
        '${workspaceFolder}/dist/**/*.js',
        '${workspaceFolder}/dist/*.js',
      },
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Compile & Debug Simple TS',
      type = custom_adapter,
      request = 'launch',
      preLaunchTask = 'npm run build-ts',
      -- preLaunchTask = 'tsc',
      program = '${workspaceFolder}/out/index.js',
      -- program = '${file}/',
      -- args = {
      --   '${workspaceFolder}/out/helloworld.js',
      -- },
      outFiles = {
        '${workspaceFolder}/out/*.js',
      },
      resolveSourceMapLocations = {
        '${workspaceFolder}/out/**/*.js',
        '${workspaceFolder}/out/*.js',
      },
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Mocha Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/mocha/bin/mocha.js",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    }
  }
end

require("dapui").setup()

require("nvim-dap-virtual-text").setup{
  virt_text_win_col = 80,
  highlight_changed_variables = true
}

require('Comment').setup()

-- Enable autopairs completion
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt", "vim" },
})

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_document_symbols, { desc = '[S]earch [S]ymbol' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim' },

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- setup nvim-tree

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()

--- empty setup using defaults
require("auto-save").setup()

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<Space>k', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
  -- nmpa('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end
-- Mapping for formating a buffer
vim.keymap.set('n', '<space>f', '<cmd>Format<cr>', { noremap = true, silent = true, buffer = 0 })

-- vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { silent = true })

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tsserver = {
    filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx", "javascriptreact", "javascript.jsx" },
    -- cmd = {"typescript-language-server", "--stdio"}
  },
  tailwindcss = {
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  },
  emmet_ls = {
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
  },
  sumneko_lua = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
      telemetry = { enable = false },
      completion = {
        callSnippet = "Replace"
      }
    },
  },
}

-- Setup neovim lua configuration
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
  ...
})
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()



-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
  },
}
-- enable vscode-like snip
require("luasnip.loaders.from_vscode").lazy_load()
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  size = 10,
  open_mapping = [[<c-t>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "horizontal",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new {
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "none",
    width = 100000,
    height = 100000,
  },
  on_open = function(_)
    vim.cmd "startinsert!"
    -- vim.cmd "set laststatus=0"
  end,
  on_close = function(_)
    -- vim.cmd "set laststatus=3"
  end,
  count = 99,
}

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local node = Terminal:new { cmd = "node", hidden = true }

function _NODE_TOGGLE()
  node:toggle()
end

local ncdu = Terminal:new { cmd = "ncdu", hidden = true }

function _NCDU_TOGGLE()
  ncdu:toggle()
end

local htop = Terminal:new { cmd = "htop", hidden = true }

function _HTOP_TOGGLE()
  htop:toggle()
end

