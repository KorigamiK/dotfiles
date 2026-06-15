---@type NvPluginSpec[]
return {
  { import = "nvchad.blink.lazyspec" },

  {
    "saghen/blink.cmp",
    opts = { keymap = { ["<C-y>"] = { "fallback" } } },
  },

  { "nvchad/menu",                   enabled = false },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n",          desc = "Comment toggle current line" },
      { "gc",  mode = { "v", "o" }, desc = "Comment toggle linewise" },
      { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n",          desc = "Comment toggle current block" },
      { "gb",  mode = { "v", "o" }, desc = "Comment toggle blockwise" },
      { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
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
          url = "https://api.groq.com/openai/v1/chat/completions",
          model = "deepseek-r1-distill-llama-70b",
          api_key_name = "GROQ_API_KEY",
        },
        github = {
          url = "https://models.github.ai/inference/chat/completions",
          model = "openai/gpt-5-chat",
          api_key_name = "GITHUB_AI_TOKEN",
        },
        anthropic = {
          url = "https://api.anthropic.com/v1/messages",
          model = "claude-sonnet-4-20250514",
          api_key_name = "ANTHROPIC_STUDENT_API_KEY",
        },
        openrouter = {
          url = "https://openrouter.ai/api/v1/chat/completions",
          model = "deepseek/deepseek-chat",
          api_key_name = "OPENROUTER_API_KEY",
        },
        mistral = {
          url = "https://api.mistral.ai/v1/chat/completions",
          model = "mistral-large-latest",
          api_key_name = "MISTRALAI_API_KEY",
        },
        gemini = {
          url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
          model = "gemini-2.5-pro",
          api_key_name = "GEMINI_API_KEY",
        },
      },
    },
  },

  --[[
  {
    "hrsh7th/nvim-cmp",
    -- opts = { experimental = { ghost_text = { hl_group = "Comment" } } },
  },
  ]]

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
    config = function(_, opts)
      local ts = require "nvim-treesitter"
      ts.setup { install_dir = opts.install_dir }

      local cfg = opts.incremental_selection
      if not (cfg and cfg.enable and cfg.keymaps) then
        return
      end

      local incremental_state = {}

      local function node_range_to_visual_end(sr, sc, er, ec)
        if ec > 0 then
          return er, ec - 1
        end

        if er > sr then
          local line = vim.api.nvim_buf_get_lines(0, er - 1, er, false)[1] or ""
          return er - 1, math.max(#line - 1, 0)
        end

        return sr, sc
      end

      local function select_ts_node(node)
        local sr, sc, er, ec = node:range()
        local vr, vc = node_range_to_visual_end(sr, sc, er, ec)

        local m = vim.fn.mode()
        if m == "v" or m == "V" or m == "\22" then
          vim.cmd "normal! \27"
        end
        vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
        vim.cmd "normal! v"
        vim.api.nvim_win_set_cursor(0, { vr + 1, vc })
      end

      local function ts_expand_selection()
        local bufnr = vim.api.nvim_get_current_buf()
        local state = incremental_state[bufnr] or { stack = {} }
        local mode = vim.fn.mode()
        local current_node = vim.treesitter.get_node()

        if not current_node then
          return
        end

        if mode == "n" then
          state.stack = {}
        elseif #state.stack > 0 then
          local top = state.stack[#state.stack]
          if not vim.treesitter.is_ancestor(top, current_node) and top:id() ~= current_node:id() then
            state.stack = {}
          end
        end

        local node = state.stack[#state.stack]
        if not node then
          node = current_node
        else
          node = node:parent()
        end

        if not node then
          return
        end

        state.stack[#state.stack + 1] = node
        incremental_state[bufnr] = state
        select_ts_node(node)
      end

      local function ts_shrink_selection()
        local bufnr = vim.api.nvim_get_current_buf()
        local state = incremental_state[bufnr]
        if not state or #state.stack < 2 then
          return
        end

        table.remove(state.stack)
        select_ts_node(state.stack[#state.stack])
      end

      local seen = {}
      local expand_keys = {
        cfg.keymaps.init_selection,
        cfg.keymaps.node_incremental,
        cfg.keymaps.scope_incremental,
      }

      for _, lhs in ipairs(expand_keys) do
        if lhs and not seen[lhs] then
          seen[lhs] = true
          vim.keymap.set({ "n", "x" }, lhs, ts_expand_selection, { desc = "Expand treesitter selection" })
        end
      end

      if cfg.keymaps.node_decremental then
        vim.keymap.set("x", cfg.keymaps.node_decremental, ts_shrink_selection, { desc = "Shrink treesitter selection" })
      end
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        opts = function()
          local opts = require("configs.treesitter").textobjects
          return {
            select = {
              lookahead = opts.select.lookahead,
            },
            move = {
              set_jumps = opts.move.set_jumps,
            },
          }
        end,
        config = function(_, opts)
          local ts_opts = require "configs.treesitter"
          require("nvim-treesitter-textobjects").setup(opts)

          local textobjects = ts_opts.textobjects or {}

          if textobjects.select and textobjects.select.enable and textobjects.select.keymaps then
            for lhs, query in pairs(textobjects.select.keymaps) do
              vim.keymap.set({ "x", "o" }, lhs, function()
                require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
              end)
            end
          end

          if textobjects.move and textobjects.move.enable then
            local move = require "nvim-treesitter-textobjects.move"
            local move_keymaps = {
              goto_next_start = move.goto_next_start,
              goto_next_end = move.goto_next_end,
              goto_previous_start = move.goto_previous_start,
              goto_previous_end = move.goto_previous_end,
            }

            for group, callback in pairs(move_keymaps) do
              for lhs, query in pairs(textobjects.move[group] or {}) do
                vim.keymap.set({ "n", "x", "o" }, lhs, function()
                  callback(query, "textobjects")
                end)
              end
            end
          end

          if textobjects.swap and textobjects.swap.enable then
            local swap = require "nvim-treesitter-textobjects.swap"
            for lhs, query in pairs(textobjects.swap.swap_next or {}) do
              vim.keymap.set("n", lhs, function()
                swap.swap_next(query, "textobjects")
              end)
            end
            for lhs, query in pairs(textobjects.swap.swap_previous or {}) do
              vim.keymap.set("n", lhs, function()
                swap.swap_previous(query, "textobjects")
              end)
            end
          end
        end,
      },
      {
        "windwp/nvim-ts-autotag",
        opts = function()
          local opts = require("configs.treesitter").autotag
          return {
            opts = {
              enable_close = opts.enable,
              enable_rename = opts.enable_rename,
            },
          }
        end,
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    lazy = true,
    opts = require "configs.nvim-tree",
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-project.nvim",
      "jvgrootveld/telescope-zoxide",
    },
    opts = require "configs.telescope",
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
    "xeluxee/competitest.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = { "CompetiTest" },
    opts = {
      compile_command = {
        cpp = {
          exec = "g++",
          args = {
            "-std=c++20",
            "-DKORIGAMIK",
            "-Wall",
            "-Wpedantic",
            "-H",
            "-include-pch",
            "/Users/ori/Developer/dotfiles/snippets/debug.hpp.pch",
            "-I" .. vim.fn.expandcmd "~/Dev/projects/cpp/atcoder",
            "$(FNAME)",
            "-o",
            "$(FNOEXT)",
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
    cmd = { "CMakeBuild", "CMakeGenerate" },
    opts = {
      cmake_virtual_text_support = false,
      cmake_build_directory = function()
        return "build/${variant:buildType}"
      end,
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
          autostart = false,
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
        home = "/Users/ori/Developer/competetive_coding/learning/LeetCode/problems",
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

  -- {
  --   dir = "/home/origami/Dev/projects/lua/newchat.nvim",
  --   lazy = false,
  --   opts = {
  --     test = "opt",
  --   },
  -- },

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
        wrap = true,        -- similar to vim.o.wrap
        width = 30,         -- default % based on available width
        sidebar_header = {
          enabled = true,   -- true, false to enable/disable the header
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
          floating = false,    -- Open the 'AvanteAsk' prompt in a floating window
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
      -- "nvim-treesitter/nvim-treesitter",
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
    cmd = { "CodeCompanionChat", "CodeCompanionActions" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-treesitter/nvim-treesitter",
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

  {
    "neo451/feed.nvim",
    cmd = "Feed",
    opts = {
      feeds = {
        {
          "https://neovim.io/news.xml",
          name = "Neovim News",
          tags = { "tech", "news" }, -- tags given are inherited by all its entries
        },
        "https://korigamik.dev/rss.xml",
        "neovim/neovim/releases", -- GitHub links
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
      window = {
        layout = "float",
        width = 0.8,
        height = 0.6,
        row = 1,
      },
    },
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },

  {
    "korigamik/enlighten.nvim",
    -- event = "VeryLazy",
    opts = {
      ai = {
        provider = "openai",         -- AI provider. Only "openai" or "anthropic" or supported.
        model = "openai/gpt-5-chat", -- model name for the specified provider. Only chat completion models are supported (plus the o3-mini reasoning model)
        temperature = 0,
        tokens = 4096,
        timeout = 120, -- recommended to keep very high
      },               -- ...
    },
    keys = {
      { "<leader>ae", function() require("enlighten").edit() end,        desc = "Edit",                mode = { "n", "v" }, },
      { "<leader>ac", function() require("enlighten").chat() end,        desc = "Chat",                mode = { "n", "v" }, },
      { "<leader>ay", function() require("enlighten").keep() end,        desc = "Keep change",         mode = { "n", "v" }, },
      { "<leader>aY", function() require("enlighten").keep_all() end,    desc = "Keep all changes",    mode = "n", },
      { "<leader>an", function() require("enlighten").discard() end,     desc = "Discard change",      mode = { "n", "v" }, },
      { "<leader>aN", function() require("enlighten").discard_all() end, desc = "Discard all changes", mode = "n", },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    cmd = "TSContext",
    opts = {
      enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = false,      -- Enable multiwindow support.
      max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20,     -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = {
      preview_config = {
        border = 'single', -- Change to 'single', 'double', 'shadow', or 'none'
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    },
  },

}
