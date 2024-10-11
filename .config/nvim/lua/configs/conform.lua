return {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_organize_imports", "ruff_format" },
    javascript = { "deno_fmt" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    astro = { "prettier" },
    markdown = { "deno_fmt", "injected" },
    json = { "deno_fmt" },
    jsonc = { "deno_fmt" },
    yaml = { "prettier" },
    sh = { "shfmt" },
    tex = { "latexindent" },
    bib = { "latexindent" },

    -- clang
    c = { "clang_format" },
    cpp = { "clang_format" },
    cs = { "clang_format" },
    java = { "clang_format" },
    cuda = { "clang_format" },
    proto = { "clang_format" },

    rust = { "rustfmt" },
    toml = { "taplo" },
    dart = { "dart_format" },

    haskell = { "fourmolu" },
  },
  formatters = {
    shfmt = { prepend_args = { "-i", "2" } },
    fourmolu = { prepend_args = { "--indentation", "2" } },
    latexindent = { prepend_args = { "-m", "-l=./latexindent.yaml", } },
    injected = {
      options = {
        ignore_errors = true,
        lang_to_formatters = {
          cpp = { "clang_format" },
        },
      },
    },
  },
  log_level = vim.log.levels.ERROR,
}
