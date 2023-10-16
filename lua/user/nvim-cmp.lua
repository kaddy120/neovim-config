-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	enabled = function()
		local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
		if in_prompt then -- this will disable cmp in the Telescope window (taken from the default config)
			return false
		end
		local context = require("cmp.config.context")
		return not (context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
	end,
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Down>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Up>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),

	sources = cmp.config.sources({
		{ name = "luasnip" }, -- For luasnip users.
		-- { name = 'snippy' }, -- For snippy users.
		{ name = "nvim_lsp_signature_help" },
		{ name = "path" },
		{ name = "nvim-lspconfig" },
		{ name = "nvim_lsp" },
		{
			{ name = "buffer" },
		},
	}),
	completion = {
		keyword_length = 2,
		-- completeopts = "menu,menuone",
		-- preselect = cmp.PreselectMode.Item,
	},
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
	completion = {
		keyword_length = 4,
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	competion = {
		keyword_length = 4,
	},
})

-- enable vscode-like snip
