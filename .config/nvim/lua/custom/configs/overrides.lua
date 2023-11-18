local M = {}

M.treesitter = {
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
      swap_previous = { ["<leader>A"] = "@parameter.inner" },
      swap_next = { ["<leader>a"] = "@parameter.inner" },
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
    "cpp",
    "glsl",
    "markdown",
    "markdown_inline",
    "astro",
    "python",
    "cpp",
    "dart",
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
}

M.mason = {
  auto_install = true,
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "astro-language-server",

    -- c/cpp stuff
    "clangd",

    -- shell stuff
    "shfmt",

    --rust
    "rust-analyzer",

    -- python
    "black",
    "isort",

    -- solidity
    "nomicfoundation-solidity-language-server",
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
  extensions_list = { "themes", "terms", "project", "zoxide" },
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", ".cache" },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
    live_grep = {
      file_ignore_patterns = { "node_modules", ".git", ".venv" },
      additional_args = function(_)
        return { "--hidden", "--with-filename" }
      end,
    },
  },
  extensions = {
    project = {
      base_dirs = {
        { "~/Dev/projects", max_depth = 4 },
        { "~/Dev/docs" },
        { "~/Dev/CV" },
      },
      sync_with_nvim_tree = true,
      order_by = "recent",
      hidden_files = true,
    },
    zoxide = {
      prompt_title = "[ Walk to your path ]",
      mappings = {
        default = {
          after_action = function(selection)
            vim.notify(
              "Changed to " .. selection.path .. " (" .. selection.z_score .. ")",
              vim.log.levels.INFO,
              { title = "Zoxide updated tab path" }
            )
            require("telescope.builtin").find_files()
          end,
        },
      },
    },
  },
}

return M
