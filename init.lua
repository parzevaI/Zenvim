local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-------------------------------------- options ------------------------------------------
opt.relativenumber = true
opt.wrap = false


vim.cmd "let g:sneak#s_next = 1"

-- require('luasnip').filetype_extend("svelte", {"javascript", "html", "css"})