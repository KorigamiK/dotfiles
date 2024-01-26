local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lsp"
    end, -- Override to setup mason-lspconfig
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = require "custom.configs.conform",
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "windwp/nvim-ts-autotag" },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-project.nvim", "jvgrootveld/telescope-zoxide" },
    opts = overrides.telescope,
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
      commit_editor = {
        kind = "replace",
      },
    },
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
    "Exafunction/codeium.vim",
    enabled = true,
    config = function()
      vim.g.codeium_no_map_tab = true
      vim.keymap.set("i", "<C-y>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true }) -- Accept completion is Ctrl + g
      --[[ vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true }) ]]

      --[[ Clear current suggestion 	codeium#Clear() 	<C-]>
      Next suggestion 	codeium#CycleCompletions(1) 	<M-]>
      Previous suggestion 	codeium#CycleCompletions(-1) 	<M-[>
      Insert suggestion 	codeium#Accept() 	<Tab>
      Manually trigger suggestion 	codeium#Complete() 	<M-Bslash> ]]
    end,
    event = "InsertEnter",
  },

  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        keys = {
          accept = "<C-y>",
          accept_word = true,
          accept_line = true,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        env = false,
      },
    },
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
          -- exec = "rustc",
          -- args = { "$(FNAME)", "-o", "$(FNOEXT)" },
          exec = "cargo",
          args = { "build", "--release", "--bin", "$(FNOEXT)" },
        },
      },
      run_command = {
        cpp = { exec = "./$(FNOEXT)" },
        py = { exec = "python3", args = { "$(FNAME)" } },
        haskell = { exec = "./$(FNOEXT)" },
        rust = {
          -- exec = "cargo",
          -- args = { "metadata", "--format-version", "1", "--no-deps", "|", "jq", "-r", ".target_directory" },
          exec = "../../target/release/$(FNOEXT)",
        },
      },
      testcases_use_single_file = true,
      evaluate_template_modifiers = true,
      template_file = "$(HOME)/Dev/projects/dotfiles/snippets/template.$(FEXT)",
      received_contests_directory = "$(HOME)/Dev/projects/competetive_coding/contests/$(JUDGE)/$(CONTEST)/",
      received_problems_path = "$(HOME)/Dev/projects/competetive_coding/learning/$(JUDGE)/$(CONTEST)/$(PROBLEM).$(FEXT)",
    },
  },

  -- Cmake
  {
    "Civitasv/cmake-tools.nvim",
    enabled = true,
    cmd = { "CMakeBuild" },
    opts = {},
  },

  --[[ -- Haskell
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    version = "^2", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function()
      require("custom.configs.haskell-tools").setup()
      require("core.utils").load_mappings "haskell"
    end,
  }, ]]

  -- LaTeX
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      require("custom.configs.vimtex").setup()
    end,
  },

  -- Hyprland config
  {
    "theRealCarneiro/hyprland-vim-syntax",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = "hypr",
  },

  -- Rust
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    dependencies = { { "lvimuser/lsp-inlayhints.nvim", opts = {} } },
    config = function()
      vim.g.rustaceanvim = {
        inlay_hints = {
          auto = false
        },
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          capabilities = require("plugins.configs.lspconfig").capabilities,
          on_attach = function(client, bufnr)
            require("plugins.configs.lspconfig").on_attach(client, bufnr)
            require("lsp-inlayhints").on_attach(client, bufnr)
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint(bufnr, true)
            end
          end,
        },
      }
    end,
  },

  -- Flutter
  {
    "akinsho/flutter-tools.nvim",
    enabled = true,
    ft = "dart",
    opts = {
      widget_guides = { enabled = false },
      closing_tags = {
        enabled = true, -- set to false to disable
      },
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
        on_attach = require("plugins.configs.lspconfig").on_attach,
        capabilities = require("plugins.configs.lspconfig").capabilities,
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = { "/home/origami/.pub-cache/" },
        },
      },
    },
  },

  -- Zen mode
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    opts = {},
  },

  -- LSP diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle" },
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
      require("trouble").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    keys = function()
      return { "<leader>" }
    end,
    opts = {
      motions = { count = false },
      plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
    },
  },

  -- AI
  --[[ {
    "jackMort/ChatGPT.nvim",
    -- event = "VeryLazy",
    cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions", "ChatGPTRun" },
    opts = { api_key_cmd = "secret-tool lookup password openai" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  } ]]
}

return plugins
