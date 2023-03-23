local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
    sources = {
        formatting.stylua,
        formatting.prettier.with({extra_args={'--single-quote', '--jsx-single-quote'}})
    },
})
