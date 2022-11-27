local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Switch buffer
keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
keymap("n", "<S-l>", ":bnext<CR>", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

-- Better window movement
keymap("n", "<C-h>", "<C-w>h", default_opts)
keymap("n", "<C-j>", "<C-w>j", default_opts)
keymap("n", "<C-k>", "<C-w>k", default_opts)
keymap("n", "<C-l>", "<C-w>l", default_opts)

-- Yank to end of line
keymap("n", "Y", "y$", default_opts)

-- Close buffer
keymap("n", "<leader>q", ":NvimTreeClose<CR>:bdelete<CR>", default_opts)
keymap("n", "<leader>Q", ":bw<CR>", default_opts)
-- Nvim Tree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", default_opts)
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", default_opts)

-- Save File
keymap("n", "<leader>w", ":w<CR>", default_opts)

-- Format code
keymap("n", "<leader>f", ":lua vim.lsp.buf.format(nil, 1000)", default_opts)

vim.api.nvim_create_autocmd("BufWritePre", {
	command = "lua vim.lsp.buf.format(nil, 1000)",
	pattern = "*.cpp,*.css,*.go,*.h,*.hpp,*.html,*.js,*.json,*.jsx,*.lua,*.md,*.py,*.rs,*.ts,*.tsx,*.yaml",
})
