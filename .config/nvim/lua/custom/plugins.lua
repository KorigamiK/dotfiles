local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope-project.nvim",
    lazy = false,
    keys = "<leader>fp",
    cmd = "Telescope",
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-project.nvim" },
    opts = overrides.telescope,
  },

  {
    "mg979/vim-visual-multi",
    lazy = false,
    enabled = false,
  },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    opts = {},
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
      -- vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      -- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      -- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
      --Clear current suggestion 	codeium#Clear() 	<C-]>
      -- Next suggestion 	codeium#CycleCompletions(1) 	<M-]>
      -- Previous suggestion 	codeium#CycleCompletions(-1) 	<M-[>
      -- Insert suggestion 	codeium#Accept() 	<Tab>
      -- Manually trigger suggestion 	codeium#Complete() 	<M-Bslash>
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
    url = "https://git.sr.ht/~p00f/cphelper.nvim",
    enable = false,
    -- cmd = { "CphReceive", "CphTest", "CphRetest", "CphEdit", "CphDelete" },
    config = function()
      vim.g["cph#dir"] = "/home/korigamik/Dev/projects/competetive_coding/contests"
      vim.g["cph#lang"] = "cpp"
    end,
  },

  {
    "xeluxee/competitest.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("competitest").setup {
        compile_command = {
          cpp = {
            exec = "g++",
            args = { "$(FNAME)", "-o", "$(FNOEXT)", "-DKORIGAMIK", "-std=c++20", "-O2", "-H", "-Wall" },
          },
        },
        run_command = {
          cpp = { exec = "./$(FNOEXT)" },
          py = { exec = "python3", args = { "$(FNAME)" } },
        },
        testcases_use_single_file = true,
        template_file = "~/Dev/projects/dotfiles/snippets/template.$(FEXT)",
      }
    end,
    cmd = { "CompetiTest" },
  },

  -- Cmake
  {
    "Civitasv/cmake-tools.nvim",
    enabled = true,
    cmd = { "CMakeBuild" },
    opts = {},
  },

  -- Haskell
  --[[
  {
    "mrcjkb/haskell-tools.nvim",
    ft = "haskell",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      local ht = require "haskell-tools"
      local def_opts = { noremap = true, silent = true }
      ht.start_or_attach {
        hls = {
          on_attach = function(_, bufnr)
            local opts = vim.tbl_extend("keep", def_opts, { buffer = bufnr })
            -- haskell-language-server relies heavily on codeLenses,
            -- so auto-refresh (see advanced configuration) is enabled by default
            vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, opts)
            vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts)
            vim.keymap.set("n", "<space>ea", ht.lsp.buf_eval_all, opts)
          end,
        },
      }
    end,
  },
  --]]

  -- LaTeX
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      require("custom.configs.vimtex").setup()
    end,
  },

  -- Flutter
  {
    "akinsho/flutter-tools.nvim",
    enabled = true,
    ft = "dart",
    opts = {
      decorations = {
        statusline = {
          app_version = false,
          device = true,
        },
      },
      widget_guides = {
        enabled = false,
      },
      closing_tags = {
        enabled = true, -- set to false to disable
      },
      dev_log = {
        enabled = true,
      },
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
          analysisExcludedFolders = {
            "/home/origami/.pub-cache/",
          },
        },
      },
    },
  },
}

return plugins
