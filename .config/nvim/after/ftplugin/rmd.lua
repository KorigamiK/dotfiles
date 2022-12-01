-- compile rmd file to pdf file in neovim when pressing <F5>

-- vim.cmd("au BufRead,BufNewFile *.rmd set filetype=markdown")
-- vim.cmd("au BufRead,BufNewFile *.Rmd set filetype=markdown")

local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

keymap("n", "<F5>", ":silent !Rscript -e \"rmarkdown::render('%:p')\" <CR>", default_opts)

keymap(
	"n",
	"<F6>",
	":silent !Rscript -e \"rmarkdown::render('%:p', output_format = 'html_document')\" <CR>",
	default_opts
)
