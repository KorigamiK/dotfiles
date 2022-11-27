local M = {}

local whichkey = require("which-key")

function M.setup()
	local conf = {
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
		},
	}

	local keymaps_f = nil -- File search
	local keymaps_p = nil -- Project search

	keymaps_f = {
		name = "Find",
		f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
		b = { "<cmd>Telescope buffers<cr>", "Buffers" },
		o = { "<cmd>Telescope oldfiles<cr>", "Old files" },
		g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
		c = { "<cmd>Telescope commands<cr>", "Commands" },
		e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	}

	keymaps_p = {
		name = "Project",
		p = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "List" },
		s = { "<cmd>Telescope repo list<cr>", "Search" },
	}

	if false then
		keymaps_f = {
			name = "Find",
			f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
			b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
			o = { "<cmd>FzfLua oldfiles<cr>", "Old files" },
			g = { "<cmd>FzfLua live_grep<cr>", "Live grep" },
			c = { "<cmd>FzfLua commands<cr>", "Commands" },
			e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
		}
	end

	local opts = {
		mode = "n", -- Normal mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	}

	local mappings = {
		["w"] = { "<cmd>update!<CR>", "Save" },
		["Q"] = { "<cmd>q!<CR>", "Quit" },

		b = {
			name = "Buffer",
			c = { "<Cmd>bd!<Cr>", "Close current buffer" },
			D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
		},

		f = keymaps_f,
		p = keymaps_p,

		z = {
			name = "Packer",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			p = { "<cmd>PackerProfile<cr>", "Profile" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
		},

		g = {
			name = "Git",
			s = { "<cmd>Neogit<CR>", "Status" },
			l = { "<cmd>Neogit log<CR>", "Log" },
			b = { "<cmd>Telescope git_branches<cr>", "Branches" },
			c = { "<cmd>Telescope git_bcommits<cr>", "Commits" },
			f = { "<cmd>Telescope git_files<cr>", "Files" },
		},
	}

	whichkey.setup(conf)
	whichkey.register(mappings, opts)
end

local lsp_mappings_opts = {
	{
		"document_formatting",
		{ ["lf"] = { "<Cmd>lua vim.lsp.buf.formatting()<CR>", "Format" } },
	},
	{
		"code_lens",
		{
			["ll"] = {
				"<Cmd>lua vim.lsp.codelens.refresh()<CR>",
				"Codelens refresh",
			},
		},
	},
	{
		"code_lens",
		{ ["ls"] = { "<Cmd>lua vim.lsp.codelens.run()<CR>", "Codelens run" } },
	},
}

local lsp_mappings = {

	l = {
		name = "LSP",
		r = { "<Cmd>Lspsaga rename<CR>", "Rename" },
		u = { "<Cmd>Telescope lsp_references<CR>", "References" },
		o = { "<Cmd>Telescope lsp_document_symbols<CR>", "Document symbols" },
		d = { "<Cmd>Telescope lsp_definitions<CR>", "Definition" },
		a = { "<Cmd>Telescope lsp_code_actions<CR>", "Code actions" },
		e = { "<Cmd>lua vim.diagnostic.enable()<CR>", "Enable diagnostics" },
		x = { "<Cmd>lua vim.diagnostic.disable()<CR>", "Disable diagnostics" },
		n = { "<Cmd>update<CR>:Neoformat<CR>", "Neoformat" },
		t = { "<Cmd>TroubleToggle<CR>", "Trouble" },
	},

	-- WIP - refactoring
	-- nnoremap <silent><leader>chd :Lspsaga hover_doc<CR>
	-- nnoremap <silent><C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
	-- nnoremap <silent><C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
	-- nnoremap <silent><leader>cpd:Lspsaga preview_definition<CR>
	-- nnoremap <silent> <leader>cld :Lspsaga show_line_diagnostics<CR>
	-- {'n', '<leader>lds', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>' },
	-- {'n', '<leader>lde', '<cmd>lua vim.diagnostic.enable()<CR>'},
	-- {'n', '<leader>ldd', '<cmd>lua vim.diagnostic.disable()<CR>'},
	-- {'n', '<leader>ll', '<cmd>lua vim.diagnostic.set_loclist()<CR>'},
	-- {'n', '<leader>lca', '<cmd>lua vim.lsp.buf.code_action()<CR>'},
	-- {'v', '<leader>lcr', '<cmd>lua vim.lsp.buf.range_code_action()<CR>'},
}

local opts = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

function M.register_lsp(client)
	whichkey.register(lsp_mappings, opts)
	local unpack = unpack or table.unpack
	for _, m in pairs(lsp_mappings_opts) do
		local capability, key = unpack(m)
		if client.server_capabilities[capability] then
			whichkey.register(key, opts)
		end
	end
end

return M
