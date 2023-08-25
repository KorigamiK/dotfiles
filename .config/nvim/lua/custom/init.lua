-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.g.snipmate_snippets_path = "~/Dev/projects/dotfiles/snippets/snipmate"
vim.g.vscode_snippets_path = "~/Dev/projects/dotfiles/snippets/vscode"

vim.api.nvim_create_autocmd({ "TextYankPost" }, { callback = function() vim.highlight.on_yank() end, })

vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

function ToggleTabline()
  if vim.opt.showtabline._value == 0 then
    vim.opt.showtabline = 2
  else
    vim.opt.showtabline = 0
  end
end
