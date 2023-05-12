local M = {}

M.treesitter = {
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
    -- disable = {
    --   "python"
    -- },
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
    "clang-format",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },
  filters = {
    custom = { "node_modules", ".git", ".cache" },
  },
  view = {
    side = "right",
  },
  renderer = {
    highlight_git = true,
    root_folder_modifier = ":~",
    icons = {
      show = {
        git = true,
      },
      glyphs = {
        git = {
          unstaged = "*"
        }
      }
    },
  },
}

M.telescope = {
  opts = {
    extensions = {
      project = {
        base_dirs = {
          { "~/Dev/projects", max_depth = 3 },
          { "~/Dev/docs" },
          { "~/Dev/CV" },
        },
        sync_with_nvim_tree = true,
        order_by = "recent",
        hidden_files = false,
      },
    },
  }
}

return M
