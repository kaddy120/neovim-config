local ok_status, autopairs = pcall(require, "nvim-autopairs")

if not ok_status then
   return
end

-- Enable autopairs completion
autopairs.setup({
  disable_filetype = { "TelescopePrompt", "vim" },
})
