---@type NvPluginSpec[]
return {
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "v", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "v", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  {
    dir = "~/Dev/projects/dotfiles/llm.nvim",
    name = "llm",
    cmd = { "LLM" },
    opts = {
      services = {
        groq = {
          url = "https://api.groq.com/openai/v1/chat/completions",
          model = "llama3-70b-8192",
          api_key_name = "GROQ_API_KEY",
        },
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    -- opts = { experimental = { ghost_text = { hl_group = "Comment" } } },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    ---@diagnostic disable-next-line: different-requires
    opts = require "configs.conform",
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-project.nvim",
      "jvgrootveld/telescope-zoxide",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    opts = require "configs.telescope",
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    opts = require "configs.nvim-tree",
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = {
      auto_install = true,
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "astro-language-server",
        "tailwindcss-language-server",
        "shfmt",
        "black",
        "isort",
        "nomicfoundation-solidity-language-server",
        "tree-sitter-cli",
        "taplo",
        "json-lsp",
      },
      ui = { border = "rounded" },
    },
  },

  {
    "NeogitOrg/neogit",
    ft = { "diff" },
    cmd = "Neogit",
    opts = {
      signs = { section = { "", "" }, item = { "", "" } },
      console_timeout = 6000,
      -- auto_show_console = false,
      kind = "tab",
    },
  },

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lsp"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup { enable = true }
    end,
    cmd = { "TSContextDisable", "TSContextEnable", "TSContextToggle" },
    lazy = false,
  },

  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        filetypes = { markdown = true },
        suggestion = {
          hide_during_completion = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-y>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
      }
    end,
  },

  {
    "xeluxee/competitest.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = { "CompetiTest" },
    opts = {
      compile_command = {
        cpp = {
          exec = "g++",
          args = { "$(FNAME)", "-o", "$(FNOEXT)", "-DKORIGAMIK", "-std=c++20", "-Wall", "-Wpedantic", "-H" },
        },
        haskell = {
          exec = "stack",
          args = { "ghc", "$(FNAME)" },
        },
        rust = {
          exec = "cargo",
          args = { "build", "--release", "--bin", "$(FNOEXT)" },
        },
      },
      run_command = {
        cpp = { exec = "./$(FNOEXT)" },
        py = { exec = "python3", args = { "$(FNAME)" } },
        haskell = { exec = "./$(FNOEXT)" },
        rust = {
          exec = "../../target/release/$(FNOEXT)",
        },
      },
      testcases_use_single_file = true,
      evaluate_template_modifiers = true,
      template_file = "$(HOME)/Dev/projects/dotfiles/snippets/template.$(FEXT)",
      received_contests_directory = "$(HOME)/Dev/projects/competetive_coding/contests/$(JUDGE)/$(CONTEST)/",
      -- received_problems_path = "$(HOME)/Dev/projects/competetive_coding/learning/$(JUDGE)/$(CONTEST)/$(PROBLEM).$(FEXT)",
    },
  },

  -- Cmake
  {
    "Civitasv/cmake-tools.nvim",
    enabled = true,
    cmd = { "CMakeBuild" },
    opts = {},
  },

  -- LaTeX
  {
    "lervag/vimtex",
    ft = "tex",
    cmd = "VimtexInverseSearch",
    config = function()
      require("configs.vimtex").setup()
    end,
  },

  -- Rust
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        inlay_hints = { auto = false },
        tools = { hover_actions = { auto_focus = true }, float_win_config = { border = "rounded" } },
        server = {
          on_init = require("nvchad.configs.lspconfig").on_init,
          on_attach = require("nvchad.configs.lspconfig").on_attach,
          capabilities = require("nvchad.configs.lspconfig").capabilities,
        },
      }
    end,
  },

  -- flutter
  {
    "akinsho/flutter-tools.nvim",
    enabled = true,
    ft = "dart",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("flutter-tools").setup {
        widget_guides = { enabled = false },
        closing_tags = { enabled = true },
        dev_log = { enabled = true, notify_errors = true, open_cmd = "tabedit" },
        dev_tools = {
          autostart = false,
          auto_open_browser = false,
        },
        outline = {
          open_cmd = "30vnew",
          auto_open = false,
        },
        lsp = {
          color = {
            enabled = true,
            background = true,
            foreground = false,
            virtual_text = true,
            virtual_text_str = "■",
          },
          on_init = require("nvchad.configs.lspconfig").on_init,
          capabilities = require("nvchad.configs.lspconfig").capabilities,
          on_attach = require("nvchad.configs.lspconfig").on_attach,
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = { "/home/origami/.pub-cache/" },
          },
        },
      }
    end,
  },

  -- LSP diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
      require("trouble").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    keys = function()
      ---@type (string|LazyKeymaps)[]
      return { "<leader>" }
    end,
    opts = {
      plugins = {
        marks = false,
        registers = false,
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = true,
          z = true,
          g = true,
        },
      },
    },
  },

  {
    "vuki656/package-info.nvim",
    event = "BufReadPost package.json",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("package-info").setup()
    end,
  },
}
