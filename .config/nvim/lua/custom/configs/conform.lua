return {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { { "deno_fmt" } },
    typescript = { { "prettier" } },
    typescriptreact = { { "prettier" } },
    html = { "prettier" },
    css = { "prettier" },
    astro = { "prettier" },
    markdown = { "deno_fmt" },
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
    dart = { "dart_format" },

    haskell = { "fourmolu" },
  },
  formatters = {
    shfmt = { prepend_args = { "-i", "2" } },
    fourmolu = { prepend_args = { "--indentation", "2" } },
    latexindent = { prepend_args = { "-m", "-l=./latexindent.yaml" } },
  },
  log_level = vim.log.levels.ERROR,
}
