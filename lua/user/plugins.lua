-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")
	use("maxmellon/vim-jsx-pretty")
	use("windwp/nvim-ts-autotag") -- auto tags editing for things like html
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" }) -- pretty code fold like vscode
	use({ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			-- Useful status updates for LSP
			use({
				"j-hui/fidget.nvim",
				tag = "legacy",
			}),
			-- Additional lua configuration, makes nvim stuff amazing
		},
	})
	-- A pretty diagnostics, references, telescope results, quickfix and location list
	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use("NvChad/nvim-colorizer.lua")

	use({ "echasnovski/mini.nvim", branch = "stable" })
	use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
	use("JoosepAlviste/nvim-ts-context-commentstring") -- language context commentting

	use({ -- Autocompletion
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"saadparwaiz1/cmp_luasnip",
			"neovim/nvim-lspconfig",
		},
	})

	use("github/copilot.vim")

	use({
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		-- tag = "v<CurrentMajor>.*",
		-- install jsregexp (optional!:).
		run = "make install_jsregexp",
	})

	use("mfussenegger/nvim-lint")
	use("jose-elias-alvarez/null-ls.nvim")
	use("rafamadriz/friendly-snippets") -- VS-Code like snippet

	use({ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use({
		"antosha417/nvim-lsp-file-operations",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
	})

	use("milisims/nvim-luaref")

	use("jose-elias-alvarez/typescript.nvim")

	use({ -- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	use("digitaltoad/vim-pug") -- add pug syntex supportu

	use("mfussenegger/nvim-dap")
	use("theHamsta/nvim-dap-virtual-text")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	})
	use({ -- nvim-tree, alternative to a nerdTree
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				-- your config goes here
				-- or just leave it empty :)
			})
		end,
	})

	-- Latex support
	use("lervag/vimtex")

	use("vimwiki/vimwiki")
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Floating terminal that is toggleable
	use("akinsho/toggleterm.nvim")

	-- Git related plugins
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("lewis6991/gitsigns.nvim")

	use("navarasu/onedark.nvim") -- Theme inspired by Atom
	use("Mofiqul/vscode.nvim")

	use("nvim-lualine/lualine.nvim") -- Fancier statusline
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" }) -- Show open buffer statusline
	use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines

	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

	use("nvim-telescope/telescope-dap.nvim") -- use telescope to interface dap
	-- Fuzzy Finder (files, lsp, etc)
	use({
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.0",
		branch = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" }, { "HUAHUAI23/telescope-dapzzzz" } },
		config = function()
			require("telescope").setup({})
			require("telescope").load_extension("dap")
			require("telescope").load_extension("i23")
		end,
	})

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
	local has_plugins, plugins = pcall(require, "custom.plugins")
	if has_plugins then
		plugins(use)
	end

	if is_bootstrap then
		require("packer").sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})
