local M = {}

local servers = {
    "bashls",
    "clangd",
    "cssls",
    "gopls",
		"html",
    "pyright",
    "rust_analyzer",
    "sumneko_lua",
    "tailwindcss",
    "tsserver",
    "eslint",
}

local has_formatter = {
    "gopls",
    "html",
    "rust_analyzer",
    "sumneko_lua",
    "tsserver"
}


local function setup_servers()
    require("config.lsp.null-ls").setup()

    local lsp_installer = require "nvim-lsp-installer"
    for _, name in pairs(servers) do
        local found, server = lsp_installer.get_server(name)
        if found and not server:is_installed() then
            print("Installing " .. name)
            server:install()
        end
    end

    require("nvim-lsp-installer").on_server_ready(function(server)
        local lsputils = require "config.lsp.utils"

        local opts = {
            on_attach = lsputils.lsp_attach,
            capabilities = lsputils.get_capabilities(),
            on_init = lsputils.lsp_init,
            on_exit = lsputils.lsp_exit,
        }
        if vim.tbl_contains(has_formatter, server.name) then
            opts.capabilities.textDocument.formatting = true
        end

        server:setup(opts)
    end)
end

function M.setup()
    setup_servers()
end

return M
