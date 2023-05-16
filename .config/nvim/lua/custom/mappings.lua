---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- tansparency toggle
    ["<leader>tt"] = { "<cmd> lua require('base46').toggle_transparency() <CR>", "Toggle Transparency" },

    -- write out
    ["<leader>x"] = { "<cmd> Bdelete <CR>", "Quit" },

    -- telescope
    ["<leader>m"] = { "<cmd> Telescope marks <CR>", "Search bookmarks" },
    ["<leader>fp"] = { "<cmd> Telescope project <CR>", "Search projects" },
    ["<leader>fg"] = { "<cmd> Telescope git_files <CR>", "Search git files"},

    -- toggle lsp
    ["<leader>ls"] = { "<cmd> LspStart <CR>", "Start lsp" },
    ["<leader>lS"] = { "<cmd> LspStop <CR>", "Stop lsp" },

    -- quit
    ["<leader>Q"] = { "<cmd> x <CR>", "Write out and exit" },
    ["<leader>q"] = { ":bufdo :Bdelete <CR>", "Quit all" },

    -- join lines
    ["gj"] = { "<cmd> join <CR>", "Join lines" },

    ["L"] = { "<cmd> bnext <CR>", "Next buffer" },
    ["H"] = { "<cmd> bprevious <CR>", "Previous buffer" },

    -- neogit
    ["<leader>gs"] = { "<cmd> Neogit <CR>", "Open neogit" },
  },
  x = {
    -- Move selected line / block of text in visual mode
    ["<A-k>"] = {":move '<-2<CR>gv-gv", "move selected line", opts = { silent = true } },
    ["<A-j>"] = {":move '>+1<CR>gv-gv", "move selected line", opts = { silent = true } },
  },
}

M.disabled = {
  -- n = {
  --     ["<leader>h"] = "",
  --     ["<C-a>"] = ""
  -- }
  disabled = {
    n = {
      ["<leader>q"] = "",
      ["<leader>ls"] = "",
      ["<leader>x"] = "",
    }
  }
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

-- more keybinds!

return M
