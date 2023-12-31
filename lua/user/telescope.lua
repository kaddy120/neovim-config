local ok_status, telescope = pcall(require, "telescope")

if not ok_status then
  return
end

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
telescope.setup({
  defaults = {
    file_ignore_patterns = {
      ".git/",
      ".cache", "%.o",
      "%.a",
      "%.out",
      "%.class",
      "%.pdf",
      "%.mkv",
      "%.mp4",
      "%.zip"},
    mappings = {
      i = {
        ["<C-q>"] = trouble.open_with_trouble,
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
      n = { ["<C-q>"] = trouble.open_with_trouble },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").lsp_document_symbols, { desc = "[S]earch [S]ymbol" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sc", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").find_files({
    search_dirs = { "~/.config/nvim" },
  })
end, { desc = "[S]earch for [C]onfig]" })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
