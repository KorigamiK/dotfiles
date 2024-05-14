local configs = require "nvchad.configs.lspconfig"

configs.defaults()

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

---@diagnostic disable-next-line: different-requires
local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "astro" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.tailwindcss.setup {
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
  autostart = false,
  on_init = on_init,
  root_dir = lspconfig.util.root_pattern "package.json",
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = true,
}

lspconfig.solidity_ls_nomicfoundation.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
