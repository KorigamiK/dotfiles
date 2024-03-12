return {
	update_focused_file = { enable = true },
	git = { enable = false },
	filters = {
		custom = { "node_modules", ".git", ".cache" },
		dotfiles = false,
		exclude = { ".gitignore", ".github" },
	},
	view = {
		float = {
			enable = true,
			open_win_config = function()
				return {
					relative = "editor",
					border = "rounded",
					width = 60,
					height = 20,
					row = (vim.api.nvim_list_uis()[1].height - 20) * 0.4,
					col = (vim.api.nvim_list_uis()[1].width - 60) * 0.5,
				}
			end,
		},
	},
	renderer = {
		highlight_git = false,
	},
}
