require "nvchad.options"

vim.g.snipmate_snippets_path = "~/Dev/projects/dotfiles/snippets/snipmate"
vim.g.vscode_snippets_path = "~/Dev/projects/dotfiles/snippets/vscode"

vim.opt.foldlevel = 1
vim.opt.foldnestmax = 1
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.relativenumber = true

-- vim.opt.conceallevel = 1
vim.o.scrolloff = 6
vim.o.guifont = "Iosevka Term:h14"
vim.opt.clipboard = ""

vim.opt.fillchars = { eob = "~" }

-- vim.opt.mouse = nil
vim.opt.pumheight = 8

vim.opt.colorcolumn = "100"
