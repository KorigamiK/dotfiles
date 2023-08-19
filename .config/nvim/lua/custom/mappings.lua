---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
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

    -- -- write out
    -- ["<leader>x"] = { "<c-w>c ", "Close current buffer" },

    -- telescope
    ["<leader>m"] = { "<cmd> Telescope marks <CR>", "Search bookmarks" },
    ["<leader>fp"] = { "<cmd> Telescope project <CR>", "Search projects" },
    ["<leader>fg"] = { "<cmd> Telescope git_files <CR>", "Search git files" },

    -- toggle lsp
    ["<leader>ls"] = { "<cmd> LspStart <CR>", "Start lsp" },
    ["<leader>lS"] = { "<cmd> LspStop <CR>", "Stop lsp" },

    -- -- quit
    ["<leader>Q"] = { "<cmd> qall <CR>", "Write out and exit" },
    ["<leader>q"] = { "<cmd> q <CR>", "Quit all" },

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
}

M.disabled = {
  n = {
    ["<leader>e"] = "",
    ["<tab>"] = "",
    ["<S-tab>"] = "",
    -- ["<leader>h"] = "",
    -- ["<C-a>"] = ""
    -- ["<leader>q"] = "",
    -- ["<leader>ls"] = "",
    -- ["<leader>x"] = "",
  },
}

M.lspconfig = {
  n = {
    ["<leader>lh"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "lsp signature_help",
    },
    ["<leader>lt"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
    },
  },
}

return M
