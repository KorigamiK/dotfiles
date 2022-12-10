local M = {}

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, _ = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

function M.setup()
	nvim_tree.setup({
		disable_netrw = true,
		hijack_netrw = true,
		respect_buf_cwd = true,
		view = {
			width = 25,
			side = "right",
			number = false,
			relativenumber = false,
			adaptive_size = false,
			mappings = {
				list = {
					{ key = "u", action = "dir_up" },
				},
			},
		},
		filters = {
			custom = { ".git" },
		},
		sync_root_with_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = true,
		},
		renderer = {
			root_folder_modifier = ":t",
			icons = {
				glyphs = {
					default = "",
					symlink = "",
					folder = {
						arrow_open = "",
						arrow_closed = "",
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = "",
					},
					git = {
						unstaged = "*",
						staged = "S",
						unmerged = "",
						renamed = "➜",
						untracked = "U",
						deleted = "",
						ignored = "◌",
					},
				},
			},
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			icons = {
				hint = "",
				info = "",
				warning = "!",
				error = "",
			},
		},
	})
end

return M
