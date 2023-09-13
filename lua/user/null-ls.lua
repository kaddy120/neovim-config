local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
	},
})


--[[ vim.api.nvim_create_autocmd({ "BufWritePost" }, { ]]
--[[   callback = function() ]]
--[[     require("lint").try_lint() ]]
--[[   end, ]]
--[[ }) ]]
