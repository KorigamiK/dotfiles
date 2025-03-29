local configs = require "nvchad.configs.lspconfig"

configs.defaults()

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

local servers = { "ts_ls", "html", "astro", "jsonls", "solidity_ls_nomicfoundation", "ocamllsp" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.pyright.setup {
  cmd = { "/home/origami/.local/share/zed/languages/pyright/node_modules/.bin/pyright-langserver", "--stdio" },
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup {
  init_options = {
    userLanguages = { stpl = "html" },
  },
  filetypes = {
    "astro",
    "astro-markdown",
    "clojure",
    "django-html",
    "htmldjango",
    "gohtml",
    "gohtmltmpl",
    "handlebars",
    "hbs",
    "html",
    "jade",
    "leaf",
    "mdx",
    "php",
    "twig",
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "javascriptreact",
    "reason",
    "rescript",
    "typescriptreact",
    "vue",
    "svelte",
    "templ",
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
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
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

lspconfig.zls.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.texlab.setup {
  autostart = false,
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.ts_ls.setup {
  autostart = true,
  on_init = on_init,
  root_dir = lspconfig.util.root_pattern "package.json",
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = false,
}

lspconfig.tinymist.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function(_, bufnr)
    return vim.fs.root(bufnr, { ".git" }) or vim.fn.expand "%:p:h"
  end,
  settings = {
    exportPdf = "onSave",
    outputPath = "$root/$dir/$name",
  },
}
local jdk_home = "/usr/lib/jvm/java-11-openjdk"
lspconfig.kotlin_language_server.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  cmd_env = {
    PATH = jdk_home .. "/bin:" .. vim.env.PATH,
    JAVA_HOME = jdk_home,
  },
}
