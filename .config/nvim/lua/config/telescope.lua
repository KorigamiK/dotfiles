local M = {}

function M.setup()
	local actions = require "telescope.actions"
	local telescope = require "telescope"

	telescope.setup {
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
				},
			},
		},
	}

	telescope.load_extension "fzf"
	telescope.load_extension "project"
	telescope.load_extension "repo"
end

return M
