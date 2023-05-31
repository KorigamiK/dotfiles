-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.g.snipmate_snippets_path = "~/Dev/projects/snippets/snipmate"
vim.g.vscode_snippets_path = "~/Dev/projects/snippets/vscode"

vim.api.nvim_create_autocmd({ "TextYankPost" }, { callback = function() vim.highlight.on_yank() end })

vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
