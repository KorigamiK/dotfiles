local configs = require "nvchad.configs.lspconfig"

configs.defaults()

-- Keep a reference to NvChad's default on_attach so we can extend it.
local default_on_attach = configs.on_attach

-- Start tinymist's built-in web preview in the default browser once the LSP attaches.
local function start_tinymist_preview(client, bufnr)
  if client.name ~= "tinymist" then
    return
  end

  client.request("workspace/executeCommand", {
    command = "tinymist.startDefaultPreview",
    arguments = { vim.api.nvim_buf_get_name(bufnr) },
  }, function(err)
    if err then
      vim.notify(("tinymist preview start failed: %s"):format(err.message or err), vim.log.levels.WARN)
    end
  end)
end

vim.lsp.config.pyright = {
  cmd = { "/home/origami/.local/share/zed/languages/pyright/node_modules/.bin/pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}

vim.lsp.config.basedpyright = {
  cmd = {
    "bun",
    "/home/origami/.local/share/zed/languages/basedpyright/node_modules/basedpyright/langserver.index.js",
    "--stdio",
  },
  settings = {
    basedpyright = {
      typeCheckingMode = "standard",
    },
  },
}

vim.lsp.config.pyrefly = {
  settings = {
    ["python.pyrefly.displayTypeErrors"] = "on",
  },
}

vim.lsp.config.tailwindcss = {
  init_options = { userLanguages = { stpl = "html" } },
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

vim.lsp.config.clangd = {
  autostart = false,
  -- fixes lsp warning: multiple different client offset
  cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
  filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp", "hxx", "hh", "cc", "cxx", "cuda" },
  flags = { debounce_text_changes = 150, exit_timeout = 1000 },
  -- set standard to c++17
}

vim.lsp.config.hls = {
  filetypes = { "haskell", "lhaskell", "cabal" },
  settings = {
    haskell = {
      formattingProvider = "fourmolu",
      cabalFormattingProvider = "cabalfmt",
    },
  },
}

vim.lsp.config.denols = {
  root_markers = { "deno.json", "deno.jsonc" },
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

vim.lsp.config.texlab = {
  autostart = false,
}

vim.lsp.config.ts_ls = {
  autostart = true,
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
  single_file_support = false,
}

vim.lsp.config.tinymist = {
  root_markers = { ".git" },
  on_attach = function(client, bufnr)
    if default_on_attach then
      default_on_attach(client, bufnr)
    end
    start_tinymist_preview(client, bufnr)
  end,
  settings = {
    exportPdf = "never", -- "onType", "never" "onSave" "onType"
    outputPath = "$root/$dir/$name",
    formatterMode = "typstyle",
    ["tinymist.preview.background.enabled"] = true,
    -- Use the built-in web preview that opens in your browser.
    ["tinymist.preview.browsing.args"] = { "--data-plane-host=127.0.0.1:0", "--invert-colors=never", "--open" },
    ["tinymist.preview.refresh"] = "onType",
    ["tinymist.preview.partialRendering"] = true,
  },
}

local jdk_home = "/usr/lib/jvm/java-11-openjdk"
vim.lsp.config.kotlin_language_server = {
  cmd_env = {
    PATH = jdk_home .. "/bin:" .. vim.env.PATH,
    JAVA_HOME = jdk_home,
  },
}

--[[ lspconfig.markdown_oxide.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = vim.tbl_deep_extend(
    "force",
    capabilities,
    -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
    -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
    { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
  ),
} ]]

local servers = {
  -- "denols",
  "ts_ls",
  "html",
  "astro",
  "jsonls",
  "solidity_ls_nomicfoundation",
  "ocamllsp",
  "vala_ls",
  "zls",
  -- "pyright",
  -- "basedpyright",
  -- "ty",
  "pyrefly",
  "tailwindcss",
  "clangd",
  "hls",
  "texlab",
  "tinymist",
  "kotlin_language_server",
}
vim.lsp.enable(servers)
