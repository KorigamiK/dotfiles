local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
-- opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.timeoutlen = 300 --	Time in milliseconds to wait for a mapped sequence to complete.

vim.o.shiftwidth = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 2

vim.api.nvim_create_autocmd("BufWritePre", {
	command = "lua vim.lsp.buf.format(nil, 1000)",
	pattern = "*.cpp,*.c,*.css,*.go,*.h,*.hpp,*.html,*.js,*.json,*.jsx,*.lua,*.md,*.rmd,*.py,*.rs,*.ts,*.tsx,*.yaml,*.tex,*.cls",
})

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

vim.api.nvim_create_autocmd("InsertEnter", { command = "set norelativenumber", pattern = "*" })
vim.api.nvim_create_autocmd("InsertLeave", { command = "set relativenumber", pattern = "*" })
vim.api.nvim_create_autocmd("TermOpen", { command = "startinsert", pattern = "*" })

function _G.statusline()
	local filepath = "%f"
	local align_section = "%="
	local percentage_through_file = "%p%%"
	return string.format("%s%s%s", filepath, align_section, percentage_through_file)
end

-- Status line
-- vim.cmd [[
--set statusline=%!v:lua.statusline()
-- set statusline=%f         " Path to the file
-- set statusline+=%=        " Switch to the right side
-- set statusline+=%l        " Current line
-- set statusline+=/         " Separator
-- set statusline+=%L        " Total lines
-- ]]

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 10

-- Bracket colors
vim.cmd("hi rainbowcol1 guifg=#dfd561")
