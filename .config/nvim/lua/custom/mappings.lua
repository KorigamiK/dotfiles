---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    -- terminal
    ["<C-b>"] = {
      function()
        require("nvterm.terminal").send("fc -s", "horizontal")
      end,
      "Run the last command in the current terminal",
    },

    -- buffers
    ["<A-y>"] = {
      function()
        print('hello')
        require("nvchad.tabufline").move_buf(-1)
      end,
      "Goto prev buffer",
    },
    ["<A-o>"] = {
      function()
        require("nvchad.tabufline").move_buf(1)
      end,
      "Goto next buffer",
    },

    -- tansparency toggle
    ["<leader>tt"] = { "<cmd> lua require('base46').toggle_transparency() <CR>", "Toggle Transparency" },

    -- resize splits
    ["<C-Up>"] = { "<cmd> resize -3 <CR>" },
    ["<C-Down>"] = { "<cmd> resize +3 <CR>" },
    ["<C-Left>"] = { "<cmd>vertical resize -3 <CR>" },
    ["<C-Right>"] = { "<cmd>vertical resize +3 <CR>" },

    -- create splits
    ["<leader>v"] = { "<cmd> vsplit <CR>", "Split vertically" },
    ["<leader>h"] = { "<cmd> split <CR>", "Split horizontally" },

    -- telescope
    ["<leader>m"] = { "<cmd> Telescope marks <CR>", "Search bookmarks" },
    ["<leader>fg"] = { "<cmd> Telescope git_files <CR>", "Search git files" },
    ["<leader>fp"] = { "<cmd> Telescope project <CR>", "Search projects" },
    ["<leader>fm"] = {
      function()
        require("conform").format { async = true, lsp_fallback = true }
      end,
      "Format buffer with Conform",
    },
    ["<leader><leader>"] = { "<cmd> Telescope resume <CR>", "Telescope Resume" },

    -- toggle lsp
    ["<leader>ls"] = { "<cmd> LspStart <CR>", "Start lsp" },
    ["<leader>lS"] = { "<cmd> LspStop <CR>", "Stop lsp" },

    -- quit
    ["<leader>Q"] = { "<cmd> qall <CR>", "Quit all" },
    ["<leader>q"] = { "<cmd> q <CR>", "Quit" },

    -- join lines
    ["gj"] = { "<cmd> join <CR>", "Join lines" },

    -- Neogit
    ["<leader>gs"] = { "<cmd>Neogit<CR>", "Open neogit" },

    ["L"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },
    ["H"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
    -- ["<tab>"] = { "<cmd> tabnext <CR>", "Next tab" },
    -- ["<S-tab>"] = { "<cmd> tabprevious <CR>", "Previous tab" },

    -- competetive coding
    ["<leader>rr"] = { "<cmd> CompetiTest run <CR>", "Compile and run test cases" },
    ["<leader>rc"] = { "<cmd> CompetiTest run_no_compile <CR>", "Run test cases" },

    -- move current line
    ["<A-j>"] = { "<cmd> m +1 <CR>", "move current line", opts = { silent = true } },
    ["<A-k>"] = { "<cmd> m -2 <CR>", "move current line", opts = { silent = true } },

    -- Zen mode
    ["<leader>n"] = { "<cmd> set nu! <CR> <cmd> ToggleTabline <CR>", "Zen mode and Toggle line number" },

    -- Zoxide
    ["<leader>z"] = { "<cmd> Telescope zoxide list <CR>", "Zoxide list" },

    -- Inaly hints
    ["<leader>ih"] = {
      function()
        require("lsp-inlayhints").toggle()
      end,
      "Toggle inlay hints",
    },
  },
  x = {
    -- Move selected line / block of text in visual mode
    ["<A-j>"] = { ":move '>+1<CR>gv-gv", "move selected line", opts = { silent = true } },
    ["<A-k>"] = { ":move '<-2<CR>gv-gv", "move selected line", opts = { silent = true } },
  },
  i = {
    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- move current line
    ["<A-j>"] = { "<cmd> m +1 <CR>", "move current line", opts = { silent = true } },
    ["<A-k>"] = { "<cmd> m -2 <CR>", "move current line", opts = { silent = true } },
  },
  t = {
    ["<C-k>"] = { "<C-\\><C-N><C-w><C-w>", "Window prev" },
  },
}

M.disabled = {
  n = {
    ["<leader>e"] = "",
    ["<tab>"] = "",
    ["<S-tab>"] = "",
    ["<leader>q"] = "",
    ["<leader>ls"] = "", -- replaced with LSP start
    -- ["<leader>h"] = "",
    -- ["<C-a>"] = ""
    -- ["<leader>x"] = "",
  },
}

M.lspconfig = {
  n = {
    ["<C-.>"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "lsp signature_help",
    },
    ["<leader>lt"] = {
      "<cmd>TroubleToggle<CR>",
      "Trouble diagnostic setloclist",
    },
  },
  i = {
    ["<C-.>"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "lsp signature_help",
    },
  },
}

--[[ M.haskell = {
  plugin = true,
  n = {
    ["<leader>li"] = {
      function()
        require("haskell-tools").hoogle.hoogle_signature()
      end,
      "launch Haskell search engine",
    },
    ["<leader>lr"] = {
      function()
        require("haskell-tools").repl.toggle()
      end,
      "toggle GHCi repl instance",
    },
    ["<leader>lc"] = {
      function()
        vim.lsp.codelens.run()
      end,
      "place a microscopic-lens on your damned code",
    },
    ["<leader>lq"] = {
      function()
        require("haskell-tools").repl.quit()
      end,
      "quit GHCi repl instance",
    },
  },
} ]]

return M
