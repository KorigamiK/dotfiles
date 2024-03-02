vim.g.snipmate_snippets_path = "~/Dev/projects/dotfiles/snippets/snipmate"
vim.g.vscode_snippets_path = "~/Dev/projects/dotfiles/snippets/vscode"

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.relativenumber = true

vim.g.markdown_fenced_languages = { "ts=typescript" }
vim.filetype.add {
  extension = { wgsl = "wgsl", stpl = "html" },
}
vim.api.nvim_create_user_command("ToggleTabline", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.showtabline._value == 0 then
    vim.opt.showtabline = 2
  else
    vim.opt.showtabline = 0
  end
end, {})

-- vim.opt.conceallevel = 1
vim.o.scrolloff = 6
vim.o.guifont = "Iosevka Term:h14"
vim.opt.clipboard = ""

vim.opt.fillchars = { eob = "~" }
