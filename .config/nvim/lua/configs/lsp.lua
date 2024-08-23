local configs = require "nvchad.configs.lspconfig"

configs.defaults()
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

lspconfig.lua_ls.setup {
  handlers = handlers,
}

local servers = { "html", "astro", "jsonls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    handlers = handlers,
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.pyright.setup {
  cmd = { "/home/origami/.local/share/zed/languages/pyright/node_modules/.bin/pyright-langserver", "--stdio" },
  handlers = handlers,
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup {
  handlers = handlers,
  init_options = {
    userLanguages = { stpl = "html" },
  },
  settings = {
    tailwindCSS = {
      classAttributes = {
        "class",
        "className",
        "class:list",
        "classList",
        "theme",
      },
    },
  },
}

lspconfig.clangd.setup {
  handlers = handlers,
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
  autostart = false,
  -- fixes lsp warning: multiple different client offset
  cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
  filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp", "hxx", "hh", "cc", "cxx" },
  -- set standard to c++17
}

lspconfig.hls.setup {
  handlers = handlers,
  on_init = on_init,
  filetypes = { "haskell", "lhaskell", "cabal" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    haskell = {
      formattingProvider = "fourmolu",
      cabalFormattingProvider = "cabalfmt",
    },
  },
}

lspconfig.denols.setup {
  handlers = handlers,
  on_init = on_init,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"] = true,
        },
      },
    },
  },
}

lspconfig.tsserver.setup {
  handlers = handlers,
  autostart = true,
  on_init = on_init,
  root_dir = lspconfig.util.root_pattern "package.json",
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = false,
}

lspconfig.solidity_ls_nomicfoundation.setup {
  handlers = handlers,
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}
