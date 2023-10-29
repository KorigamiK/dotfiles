return {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { { "deno_fmt" } },
    typescript = { { "deno_fmt" } },
    markdown = { "deno_fmt" },
    json = { "deno_fmt" },
    jsonc = { "deno_fmt" },
    sh = { "shfmt" },
    tex = { "latexindent" },

    -- clang
    c = { "clang_format" },
    cpp = { "clang_format" },
    cs = { "clang_format" },
    java = { "clang_format" },
    cuda = { "clang_format" },
    proto = { "clang_format" },

    rust = { "rustfmt" },
  },
  formatters = {
    shfmt = { prepend_args = { "-i", "2" } },
  },
  log_level = vim.log.levels.ERROR,
}
