local M = {}

function M.setup()
	vim.g.copilot_node_command = "/home/korigamik/.nvm/versions/node/v16.15.0/bin/node"
	vim.g.copilot_no_tab_map = true
	vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
	vim.g.copilot_filetypes = { ["*"] = true, ["xml"] = false, ["markdown"] = true }
	-- explicitly request the completion
	vim.api.nvim_set_keymap("i", "<C-k>", "copilot#Complete()", { silent = true, expr = true })
end

return M
