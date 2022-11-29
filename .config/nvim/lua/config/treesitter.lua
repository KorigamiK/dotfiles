local M = {}

function M.setup()
	require("nvim-treesitter.configs").setup({
		-- One of "all", "maintained" (parsers with maintainers), or a list of languages
		ensure_installed = {
			"bash",
			"cpp",
			"css",
			"go",
			"html",
			"lua",
			"make",
			"python",
			"rust",
			"tsx",
			"typescript",
			"yaml",
		},

		-- Install languages synchronously (only applied to `ensure_installed`)
		sync_install = false,

		highlight = {
			-- `false` will disable the whole extension
			enable = true,
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		rainbow = {
			enable = true,
			extended_mode = false,
		},

		textobjects = {
			select = {
				enable = true,

				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,

				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = { ["<Leader>rx"] = "@parameter.inner" },
				swap_previous = { ["<Leader>rX"] = "@parameter.inner" },
			},
			lsp_interop = {
				enable = true,
				border = "none",
				peek_definition_code = {
					["df"] = "@function.outer",
					["dF"] = "@class.outer",
				},
			},
			-- refactor = {
			--     highlight_definitions = {enable = true},
			--     highlight_current_scope = {enable = true},
			--     smart_rename = {
			--         enable = true,
			--         keymaps = {smart_rename = "grr"}
			--         -- keymaps = {smart_rename = "<leader>rn"}
			--     },
			--     navigation = {
			--         enable = true,
			--         keymaps = {
			--             goto_definition = "gnd",
			--             list_definitions = "gnD",
			--             list_definitions_toc = "gO",
			--             goto_next_usage = "<a-*>",
			--             goto_previous_usage = "<a-#>"
			--         }
			--     }
			-- }
		},
		context_commentstring = { enable = true, enable_autocmd = false },
		textsubjects = {
			enable = true,
			keymaps = {
				["."] = "textsubjects-smart",
				[";"] = "textsubjects-container-outer",
			},
		},
		matchup = { enable = true },
	})
end

return M
