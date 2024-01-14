-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

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

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

vim.api.nvim_create_user_command("ToggleTabline", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.showtabline._value == 0 then
    vim.opt.showtabline = 2
  else
    vim.opt.showtabline = 0
  end
end, {})

vim.opt.conceallevel = 1
vim.o.scrolloff = 6
vim.o.guifont = "Iosevka Term:h14"
vim.opt.clipboard = ""

--[[ vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0 ]]

-- Helper function for transparency formatting
-- vim.g.neovide_transparency = 0.6
-- vim.g.neovide_transparency = 0.8
-- vim.g.transparency = 0.8
--[[ local alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
end
vim.g.neovide_background_color = "#0f1117" .. alpha() ]]


