return {
  auto_install = false,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<TAB>",
      node_incremental = "<CR>",
      node_decremental = "<S-TAB>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_previous = { ["<leader>A"] = "@parameter.inner" },
      swap_next = { ["<leader>a"] = "@parameter.inner" },
    },
  },
  ensure_installed = {
    "vim",
    "vimdoc",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "cpp",
    "rust",
    "glsl",
    "markdown",
    "markdown_inline",
    "astro",
    "python",
    "dart",
    "haskell",
    "wgsl",
    "json",
    "jsonc",
    "yaml",
    "hyprlang",
    "cmake",
    "bibtex",
    "latex",
    "toml",
    "prisma",
    "zig",
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
  autotag = { enable = true, enable_rename = true },
  highlight = {
    disable = { "latex" },
    -- additional_vim_regex_highlighting = { "latex" },
  },
}
