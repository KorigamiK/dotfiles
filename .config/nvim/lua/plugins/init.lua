---@type NvPluginSpec[]
return {
  { "nvchad/menu", enabled = false },
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
    "melbaldove/llm.nvim",
    cmd = { "LLM" },
    opts = {
      services = {
        groq = {
          url = "https://models.inference.ai.azure.com/chat/completions",
          model = "gpt-4o",
          api_key_name = "GITHUB_AI_TOKEN",
        },
        anthropic = {
          url = "https://api.anthropic.com/v1/messages",
          model = "claude-3-5-sonnet-20241022",
          api_key_name = "ANTHROPIC_API_KEY",
        },
        openrouter = {
          url = "https://openrouter.ai/api/v1/chat/completions",
          model = "deepseek/deepseek-chat",
          api_key_name = "OPENROUTER_API_KEY",
        }
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
    },
    opts = require "configs.telescope",
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    lazy = true,
    opts = require "configs.nvim-tree",
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = {
      auto_install = true,
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
      require("treesitter-context").setup { enable = false }
    end,
    cmd = { "TSContextDisable", "TSContextEnable", "TSContextToggle" },
    lazy = false,
  },

  {
    "xeluxee/competitest.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = { "CompetiTest" },
    opts = {
      compile_command = {
        cpp = {
          exec = "g++",
          args = {
            "$(FNAME)",
            "-o",
            "$(FNOEXT)",
            "-DKORIGAMIK",
            "-std=c++20",
            "-Wall",
            "-Wpedantic",
            "-H",
            "-I" .. vim.fn.expandcmd "~/Dev/projects/cpp/atcoder",
          },
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
    opts = {
      cmake_virtual_text_support = false,
    },
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
    enabled = true,
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        inlay_hints = { auto = false },
        tools = { hover_actions = { auto_focus = true }, float_win_config = { border = "rounded" } },
        server = {
          auto_attach = false,
          on_init = require("nvchad.configs.lspconfig").on_init,
          on_attach = require("nvchad.configs.lspconfig").on_attach,
          capabilities = require("nvchad.configs.lspconfig").capabilities,
          default_settings = {
            ["rust-analyzer"] = {},
          },
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
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      package_manager = "pnpm",
    },
  },

  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "3rd/image.nvim",
        opts = {},
      },
    },
    lazy = "leetcode" ~= vim.fn.argv()[1],
    opts = {
      arg = "leetcode",
      image_support = true,
      storage = {
        home = "/home/origami/Dev/projects/competetive_coding/learning/LeetCode/problems",
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  {
    "Al0den/notion.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      autoUpdate = true,
      open = "notion",
      keys = {
        deleteKey = "d",
        editKey = "<cr>",
        openNotion = "O",
        itemAdd = "A",
        viewKey = "V",
      },
      delays = {
        reminder = 4000,
        format = 200,
        update = 10000,
      },
      notifications = true,
      editor = "light",
      viewOnEdit = {
        enabled = true, --Enable double window, view and edit simultaneously
        replace = false, --Replace current window with preview window
      },
      direction = "vsplit", --Direction windows will be opened in
      noEvent = "No events",
      debug = false,
    },
  },

  {
    dir = "/home/origami/Dev/projects/lua/newchat.nvim",
    lazy = false,
    opts = {
      test = "opt",
    },
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    enabled = false,
    lazy = false,
    version = "*",
    opts = {
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      copilot = { model = "claude-3.5-sonnet" },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
      },
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<C-y>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
      },
      hints = { enabled = false },
      windows = {
        position = "right", -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width
        sidebar_header = {
          enabled = true, -- true, false to enable/disable the header
          align = "center", -- left, center, right for title
          rounded = true,
        },
        input = {
          prefix = " ",
          height = 8, -- Height of the input window in vertical layout
        },
        edit = {
          border = "rounded",
          start_insert = true, -- Start insert mode when opening the edit window
        },
        ask = {
          floating = false, -- Open the 'AvanteAsk' prompt in a floating window
          start_insert = true, -- Start insert mode when opening the ask window
          border = "rounded",
          ---@type "ours" | "theirs"
          focus_on_apply = "ours", -- which diff to focus after applying
        },
      },
      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        autojump = true,
        ---@type string | fun(): any
        list_opener = "copen",
        --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
        --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
        --- Disable by setting to -1.
        override_timeoutlen = 500,
      },
    },
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "zbirenbaum/copilot.lua",
      "MunifTanjim/nui.nvim",
      --[[ {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      }, ]]
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
          },
        },
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    event = "InsertEnter",
    opts = {
      filetypes = {
        markdown = true,
        sh = function()
          return not string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*")
        end,
      },
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
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      highlight_headers = false,
      error_header = "> [!ERROR] Error",
      window = {
        layout = "float",
        width = 0.8,
        height = 0.6,
        row = 1,
      },
    },
  },

  {
    "nosduco/remote-sshfs.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    cmd = { "RemoteSSHFSConnect" },
    opts = {
      -- Refer to the configuration section below
      -- or leave empty for defaults
    },
  },

  {
    "NeViRAIDE/nekifoch.nvim",
    build = "chmod +x ./install.sh && ./install.sh",
    cmd = "Nekifoch",
    config = true,
  },

  {
    "nvim-pack/nvim-spectre",
    build = "make build-oxi",
    opts = {},
  },

  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanionChat" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = {
          keymaps = {
            previous_chat = {
              modes = { n = "<C-K>" },
              index = 9,
              callback = "keymaps.previous_chat",
              description = "Previous Chat",
            },
            next_chat = {
              modes = { n = "<C-J>" },
              index = 8,
              callback = "keymaps.next_chat",
              description = "Next Chat",
            },
          },
        },
      },
    },
    config = true,
  },

  {
    "gsuuon/note.nvim",
    opts = {
      -- opts.spaces are note workspace parent directories.
      -- These directories contain a `notes` directory which will be created if missing.
      -- `<space path>/notes` acts as the note root, so for space '~' the note root is `~/notes`.
      -- Defaults to { '~' }.
      spaces = {
        "~/Dev",
        -- '~/projects/foo'
      },

      -- Set keymap = false to disable keymapping
      -- keymap = {
      --   prefix = '<leader>n'
      -- }
    },
    cmd = "Note",
    ft = "note",
  },

}
