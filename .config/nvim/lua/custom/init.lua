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
  extension = { wgsl = "wgsl" },
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


--[[ VIM.G.NEOVIDE_PADDING_TOP = 0
VIM.G.NEOVIDE_PADDING_BOTTOM = 0
VIM.G.NEOVIDE_PADDING_RIGHT = 0
VIM.G.NEOVIDE_PADDING_LEFT = 0 ]]

-- HELPER FUNCTION FOR TRANSPARENCY FORMATTING
-- VIM.G.NEOVIDE_TRANSPARENCY = 0.6
-- VIM.G.NEOVIDE_TRANSPARENCY = 0.8
-- VIM.G.TRANSPARENCY = 0.8
--[[ LOCAL ALPHA = FUNCTION()
  RETURN STRING.FORMAT("%X", MATH.FLOOR(255 * (VIM.G.TRANSPARENCY OR 0.8)))
END
VIM.G.NEOVIDE_BACKGROUND_COLOR = "#0F1117" .. ALPHA() ]]
