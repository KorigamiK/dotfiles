M = {}

function M.setup()
	require("transparent").setup({
		enable = false,
		extra_groups = { "all", "NvimTreeNormal", "lualine", "WhichKeyFloat",
	"TelescopeNormal","NvimTreeCursorLine","StatusLine" },
	})
end

return M
