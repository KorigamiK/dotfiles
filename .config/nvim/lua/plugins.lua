local M = {}

_G.dump = function(...)
	print(vim.inspect(...))
end

function M.setup()
	-- Indicate first time installation
	local packer_bootstrap = false

	-- packer.nvim configuration
	local conf = {
		profile = {
			enable = true,
			threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},

		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	}

	-- Check if packer.nvim is installed
	-- Run PackerCompile if there are changes in this file
	local function packer_init()
		local fn = vim.fn
		local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
		if fn.empty(fn.glob(install_path)) > 0 then
			packer_bootstrap = fn.system({
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
			})
			vim.cmd([[packadd packer.nvim]])
		end
		vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
	end

	-- Plugins
	local function plugins(use)
		use({ "wbthomason/packer.nvim" })

		-- Load only when require
		use({ "nvim-lua/plenary.nvim", module = "plenary" })

		-- Colorscheme
		-- use({ "sainnhe/everforest" })
		-- use({ "FrenzyExists/aquarium-vim" })
		-- use({ "vv9k/bogster" })
		use({
			"KorigamiK/horizon.nvim",
			config = function()
				vim.cmd("colorscheme horizon")
			end,
		})
		-- use({ "ntk148v/vim-horizon" })

		-- Startup screen
		use({
			"goolord/alpha-nvim",
			config = function()
				require("config.alpha").setup()
			end,
		})

		-- Git
		use({
			"TimUntersberger/neogit",
			cmd = "Neogit",
			config = function()
				require("config.neogit").setup()
			end,
		})
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("config.gitsigns").setup()
			end,
		})

		-- WhichKey
		use({
			"folke/which-key.nvim",
			event = "VimEnter",
			config = function()
				require("config.whichkey").setup()
			end,
		})

		-- IndentLine
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			config = function()
				require("config.indentblankline").setup()
			end,
		})

		-- Better icons
		use({
			"kyazdani42/nvim-web-devicons",
			module = "nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup({ default = true })
			end,
		})

		-- Better Comment
		use({
			"numToStr/Comment.nvim",
			keys = { "gc", "gcc", "gbc" },
			config = function()
				require("Comment").setup({})
			end,
		})

		-- Easy hopping
		use({
			"phaazon/hop.nvim",
			cmd = { "HopWord", "HopChar1" },
			config = function()
				require("hop").setup({})
			end,
			disable = true,
		})

		-- Easy motion
		use({
			"ggandor/lightspeed.nvim",
			keys = { "s", "S", "f", "F", "t", "T" },
			config = function()
				require("lightspeed").setup({})
			end,
		})

		-- Markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
			ft = "markdown",
			cmd = { "MarkdownPreview" },
		})

		-- Status line
		use({
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			config = function()
				require("config.lualine").setup()
			end,
			requires = { "nvim-web-devicons" },
		})

		-- Buffer line
		use({
			"akinsho/nvim-bufferline.lua",
			event = "BufReadPre",
			wants = "nvim-web-devicons",
			config = function()
				require("config.bufferline").setup()
			end,
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("config.treesitter").setup()
			end,
			requires = {
				"nvim-treesitter/nvim-treesitter-textobjects",
				"nvim-treesitter/playground",
				{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
				{ "p00f/nvim-ts-rainbow" },
				{ "RRethy/nvim-treesitter-textsubjects" },
			},
		})
		use({
			"SmiteshP/nvim-gps",
			requires = "nvim-treesitter/nvim-treesitter",
			module = "nvim-gps",
			config = function()
				require("nvim-gps").setup()
			end,
		})

		-- Transparent background
		use({
			"xiyaowong/nvim-transparent",
			config = function()
				require("config.transparent").setup()
			end,
			cmd = { "TransparentToggle" },
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			opt = true,
			config = function()
				require("config.telescope").setup()
			end,
			cmd = { "Telescope" },
			module = "telescope",
			keys = { "<leader>f", "<leader>p" },
			wants = {
				"plenary.nvim",
				"popup.nvim",
				"telescope-fzf-native.nvim",
				"telescope-project.nvim",
				"telescope-repo.nvim",
			},
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				"nvim-telescope/telescope-project.nvim",
				"cljoly/telescope-repo.nvim",
			},
		})

		-- LSP
		use({
			"neovim/nvim-lspconfig",
			config = function()
				require("lspconfig.ui.windows").default_options.border = "rounded"
			end,
		})
		use({ "williamboman/nvim-lsp-installer" })
		use({ "jose-elias-alvarez/null-ls.nvim" })
		use({ "b0o/SchemaStore.nvim" })
		-- use {
		--   "tamago324/nlsp-settings.nvim",
		--   -- event = "BufReadPre",
		--   config = function()
		--     require("config.nlsp-settings").setup()
		--   end,
		-- }

		-- Github Copilot
		use({
			"github/copilot.vim",
			config = function()
				require("config.copilot").setup()
			end,
		})

		-- Nvim Tree
		use({
			"kyazdani42/nvim-tree.lua",
			cmd = "NvimTreeToggle",
			config = function()
				require("config.nvimtree").setup()
			end,
		})

		-- WakaTime
		use({
			"wakatime/vim-wakatime",
			disable = false,
		})

		-- VimTex
		use({
			"lervag/vimtex",
			ft = "tex",
			config = function()
				require("config.vimtex").setup()
			end,
		})

		-- ToggleTerm
		use({
			"akinsho/toggleterm.nvim",
			config = function()
				require("config.toggleterm").setup()
			end,
		})

		-- Better surround
		use({ "tpope/vim-surround", event = "InsertEnter" })

		-- Completion
		use({ "ray-x/lsp_signature.nvim" })
		use({
			"folke/trouble.nvim",
			event = "VimEnter",
			cmd = { "TroubleToggle", "Trouble" },
			config = function()
				require("trouble").setup({ auto_open = false })
			end,
		})
		use({
			"onsails/lspkind-nvim",
			config = function()
				require("lspkind").init()
			end,
		})
		use({
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			opt = true,
			config = function()
				require("config.cmp").setup()
			end,
			wants = { "LuaSnip" },
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"ray-x/cmp-treesitter",
				-- "hrsh7th/cmp-cmdline",
				"saadparwaiz1/cmp_luasnip",
				-- "hrsh7th/cmp-calc",
				-- "f3fora/cmp-spell",
				-- "hrsh7th/cmp-emoji",
				{
					"L3MON4D3/LuaSnip",
					wants = "friendly-snippets",
					config = function()
						require("config.luasnip").setup()
					end,
				},
				"rafamadriz/friendly-snippets",
				disable = false,
			},
		})

		-- -- Lua development
		-- use({ "folke/lua-dev.nvim", event = "VimEnter" })

		-- Auto pairs
		use({
			"windwp/nvim-autopairs",
			wants = "nvim-treesitter",
			module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
			config = function()
				require("config.autopairs").setup()
			end,
		})

		-- Auto tag
		use({
			"windwp/nvim-ts-autotag",
			wants = "nvim-treesitter",
			event = "InsertEnter",
			config = function()
				require("nvim-ts-autotag").setup({ enable = true })
			end,
		})

		-- Discord
		use({
			"andweeb/presence.nvim",
			config = function()
				require("presence"):setup({
					neovim_image_text = "Neovim",
					presence_log_level = "error",
					presence_editing_text = "Editing « %s »",
					presence_file_explorer_text = "Browsing files",
					presence_reading_text = "Reading  « %s »",
					presence_workspace_text = "Working on « %s »",
				})
			end,
		})

		-- Bootstrap Neovim
		if packer_bootstrap then
			print("Restart Neovim required after installation!")
			require("packer").sync()
		end

		-- LSP Lines for redering diagnostics
		-- use({
		-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		-- 	config = function()
		-- 		require("lsp_lines").setup()
		-- 	end,
		-- })

		-- Rust
		use({ "rust-lang/rust.vim", event = "VimEnter" })
		use({
			"simrat39/rust-tools.nvim",
			after = "nvim-lspconfig",
			config = function()
				require("rust-tools").setup({})
			end,
		})
		use({
			"Saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			config = function()
				require("crates").setup()
			end,
		})
	end

	packer_init()

	local packer = require("packer")
	packer.init(conf)
	packer.startup(plugins)

	-- Bootstrap Neovim
	require("config.lsp").setup()
	-- require("config.dap").setup()
end

return M
