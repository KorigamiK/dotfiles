local M = {}

M.treesitter = {
  auto_install = false,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental = "<M-space>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
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
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
  ensure_installed = {
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",

    -- c/cpp stuff
    "clangd",
  },
}

-- git support in nvimtree
M.nvimtree = {
  update_focused_file = { enable = true },
  git = { enable = false },
  filters = { custom = { "node_modules", ".git", ".cache" } },
  view = { side = "right" },
  renderer = {
    highlight_git = true,
    root_folder_modifier = ":~",
    icons = {
      show = { git = true },
      glyphs = { git = { unstaged = "*" } },
    },
  },
}

M.telescope = {
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", ".cache" },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    }
  },
  extensions = {
    project = {
      base_dirs = {
        { "~/Dev/projects", max_depth = 3 },
        { "~/Dev/docs" },
        { "~/Dev/CV" },
      },
      sync_with_nvim_tree = true,
      order_by = "recent",
      hidden_files = true,
    },
  },
  extensions_list = { "themes", "terms", "project" },
}

return M
