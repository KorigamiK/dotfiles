local M = {}

function M.setup()
	-- Set conceallevel
	vim.opt.conceallevel = 0
	-- Enable formatting
	vim.g.vimtex_format_enabled = 1
	-- Disable imaps (using Ultisnips)
	vim.g.vimtex_imaps_enabled = 0
	-- Do not open pdfviwer on compile
	vim.g.vimtex_view_automatic = 1
	-- Disable conceal
	vim.g.vimtex_syntax_conceal = {
		accents = 1,
		cites = 1,
		fancy = 1,
		greek = 1,
		math_bounds = 0,
		math_delimiters = 1,
		math_fracs = 1,
		math_super_sub = 1,
		math_symbols = 1,
		sections = 1,
		styles = 1,
	}
	-- Disable quickfix auto open
	vim.g.vimtex_quickfix_ignore_mode = 0
	-- PDF viewer settings
	vim.g.vimtex_view_general_viewer = "okular"
	vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
	-- Auto open quickfix on compile erros
	vim.g.vimtex_quickfix_mode = 1
	-- Latex warnings to ignore
	vim.g.vimtex_quickfix_ignore_filters = {
		"Command terminated with space",
		"LaTeX Font Warning: Font shape",
		"Package caption Warning: The option",
		[[Underfull \\hbox (badness [0-9]*) in]],
		"Package enumitem Warning: Negative labelwidth",
		[[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in]],
		[[Package caption Warning: Unused \\captionsetup]],
		"Package typearea Warning: Bad type area settings!",
		[[Package fancyhdr Warning: \\headheight is too small]],
		[[Underfull \\hbox (badness [0-9]*) in paragraph at lines]],
		"Package hyperref Warning: Token not allowed in a PDF string",
		[[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
	}
	vim.g.vimtex_fold_enabled = 0
	vim.g.vimtex_fold_manual = 1
	vim.g.vimtex_fold_types = {
		cmd_addplot = { cmds = { "addplot[+3]?" } },
		cmd_multi = {
			cmds = {
				"%(re)?new%(command|environment)",
				"providecommand",
				"presetkeys",
				"Declare%(Multi|Auto)?CiteCommand",
				"Declare%(Index)?%(Field|List|Name)%(Format|Alias)",
			},
		},
		cmd_single = {
			cmds = { "hypersetup", "tikzset", "pgfplotstableread", "lstset" },
		},
		cmd_single_opt = {
			cmds = { "usepackage", "includepdf" },
		},
		comments = {
			enabled = 0,
		},
		env_options = vim.empty_dict(),
		envs = {
			blacklist = {},
			whitelist = { "figure", "frame", "table", "example", "answer" },
		},
		items = { enabled = 0 },
		markers = vim.empty_dict(),
		preamble = { enabled = 0 },
		sections = {
			parse_levels = 0,
			parts = { "appendix", "frontmatter", "mainmatter", "backmatter" },
			sections = {
				"%(add)?part",
				"%(chapter|addchap)",
				"%(section|section\\*)",
				"%(subsection|subsection\\*)",
				"%(subsubsection|subsubsection\\*)",
				"paragraph",
			},
		},
	}
end

return M
