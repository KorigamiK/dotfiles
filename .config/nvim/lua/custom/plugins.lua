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
      extensions_list = { "themes", "terms", "project" },
    },
  },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  {
    "mg979/vim-visual-multi",
    lazy = false,
    enabled = false,
  },

  {
    "TimUntersberger/neogit",
    keys = "<leader>gs",
    cmd = "Neogit",
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
    url = "https://git.sr.ht/~p00f/cphelper.nvim",
    enable = false,
    cmd = { "CphReceive", "CphTest", "CphRetest", "CphEdit", "CphDelete" },
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
          cpp = { exec = "g++", args = { "$(FNAME)", "-o", "$(FNOEXT)", "-DONLINE_JUDGE", "-std=c++17", "-O2" } },
        },
        run_command = {
          cpp = { exec = "./$(FNOEXT)" },
        },
      }
    end,
    cmd = { "CompetiTestReceive", "CompetiTestRun", "CompetiTestDelete", "CompetiTestEdit", "CompetiTestAdd" },
  },

  { "moll/vim-bbye", lazy = false },
}

return plugins
