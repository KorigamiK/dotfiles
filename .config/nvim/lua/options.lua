require "nvchad.options"

vim.opt.foldlevel = 99
-- vim.opt.foldnestmax = 1
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.relativenumber = true

-- vim.opt.conceallevel = 1
vim.o.scrolloff = 6
-- vim.o.guifont = "Berkeley Mono:h16"
vim.opt.clipboard = ""

vim.opt.fillchars = { eob = "~" }

-- vim.opt.mouse = nil
vim.opt.pumheight = 8

vim.opt.colorcolumn = "100"
vim.opt.showbreak = "󱞩 "

vim.opt.showcmd = false

require("lspconfig.ui.windows").default_options.border = "single"

vim.opt.concealcursor = 'nc'
