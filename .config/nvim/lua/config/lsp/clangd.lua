local M = {}

local lsputils = require("config.lsp.utils")

function M.setup(clangd_server)
	local capabilities = lsputils.get_capabilities()
	capabilities.offsetEncoding = "utf-16"
	return {
		capabilities,
		on_attach = lsputils.lsp_attach,
		on_init = lsputils.lsp_init,
		on_exit = lsputils.lsp_exit,
		flags = { debounce_text_changes = 150 },
		cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" }, -- fixes null-ls warning: multiple different client offset
		filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp", "hxx", "hh", "cc", "cxx" },
	}
end

return M
