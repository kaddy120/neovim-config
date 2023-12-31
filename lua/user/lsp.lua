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
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<Space>k", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Diagnostic keymaps
  nmap("[d", vim.diagnostic.goto_prev, "")
  nmap("]d", vim.diagnostic.goto_next, "")
  nmap("<leader>e", vim.diagnostic.open_float, "")
  nmap("<leader>q", vim.diagnostic.setloclist, "")
  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")
  -- nmpa('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
  nmap("<leader>f", "<cmd>Format<cr>", "Format current buffer")
end
-- Mapping for formating a buffer

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
    completions = { completeFunctionCalls = true },
    filetypes = {
      "javascript",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "javascript.jsx",
      "javascriptreact",
    },
    preferences = {
      includePackageJsonAutoImports= "on",
      includeCompletionsForImportStatements = true;
    }
    -- cmd = {"typescript-language-server", "--stdio"}
  },
  tailwindcss = {
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
  },
  emmet_ls = {
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    },
  },
  --
  -- sumneko_lua = {
  --   Lua = {
  --     workspace = {
  --       library = vim.api.nvim_get_runtime_file("", true),
  --       checkThirdParty = false
  --     },
  --     telemetry = { enable = false },
  --     completion = {
  --       callSnippet = "Replace"
  --     }
  --   },
  -- },
}

-- Setup neovim lua configuration
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    })
  end,
})

require("lspconfig").eslint.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    --[[ if client.server_capabilities.documentFormattingProvider then ]]
    --[[   local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true }) ]]
    --[[   vim.api.nvim_create_autocmd("BufWritePre", { ]]
    --[[     pattern = "*", ]]
    --[[     callback = function() ]]
    --[[       vim.lsp.buf.format({ async = true }) ]]
    --[[     end, ]]
    --[[     group = au_lsp, ]]
    --[[   }) ]]
    --[[ end ]]
  end,
})

require("lspconfig").jsonls.setup({
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = false,
  },
})

require('lspconfig').html.setup {}
-- Turn on lsp status information
require("fidget").setup()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
