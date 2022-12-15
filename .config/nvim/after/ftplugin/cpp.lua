local wk = require("which-key")
local opts = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = false,
	noremap = true,
	nowait = true,
}
local mappings = {
	["r"] = {
		name = "Run",
		c = { ":!cmake --build build/linux", "cmake build" },
	},
}
wk.register(mappings, opts)
