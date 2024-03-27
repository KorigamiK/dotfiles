require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { nowait = true })
map("i", "<C-s>", "<cmd>w<cr>", { desc = "Save" })

-- buffers
map("n", "<A-y>", function()
  require("nvchad.tabufline").move_buf(-1)
end, { noremap = true, silent = true, expr = false, nowait = true })
map("n", "<A-o>", function()
  require("nvchad.tabufline").move_buf(1)
end, { noremap = true, silent = true, expr = false, nowait = true })

-- tansparency toggle
map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end, { desc = "Toggle Transparency" })

-- create splits
map("n", "<leader>v", "<cmd> vsplit <CR>", {
  desc = "Split vertically",
})
map("n", "<leader>h", "<cmd> split <CR>", {
  desc = "Split horizontally",
})

map("n", "<leader>fm", function()
  ---@diagnostic disable-next-line: different-requires
  require("conform").format()
end, { desc = "File Format with conform" })

-- telescope
map("n", "<leader>m", "<cmd> Telescope marks <CR>", {
  desc = "Search bookmarks",
})
map("n", "<leader>fg", "<cmd> Telescope git_files <CR>", {
  desc = "Search git files",
})
map("n", "<leader>fp", "<cmd> Telescope project <CR>", {
  desc = "Search projects",
})
map("n", "<leader><leader>", "<cmd> Telescope resume <CR>", {
  desc = "Telescope Resume",
})
-- zoxide
map("n", "<leader>z", "<cmd> Telescope zoxide list <CR>", {
  desc = "Zoxide list",
})
-- toggle lsp
map("n", "<leader>ls", "<cmd> LspStart <CR>", {
  desc = "Start lsp",
})
map("n", "<leader>lS", "<cmd> LspStop <CR>", {
  desc = "Stop lsp",
})
-- quit
map("n", "<leader>Q", "<cmd> qall <CR>", {
  desc = "Quit all",
})
map("n", "<leader>q", "<cmd> q <CR>", {
  desc = "Quit",
})
-- neogit
map("n", "<leader>gs", "<cmd>Neogit<CR>", {
  desc = "Open neogit",
})
-- move buffers
map("n", "L", function()
  require("nvchad.tabufline").next()
end, {
  desc = "Goto next buffer",
})
map("n", "H", function()
  require("nvchad.tabufline").prev()
end, { desc = "Goto prev buffer" })

-- trouble
map("n", "<leader>lt", "<cmd>TroubleToggle<CR>", { desc = "Toggle trouble" })

-- close all buffers
map("n", "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs()
end, {
  desc = "Close all buffers",
})
-- competetive coding
map("n", "<leader>rr", "<cmd> CompetiTest run <CR>", {
  desc = "Compile and run test cases",
})
map("n", "<leader>rc", "<cmd> CompetiTest run_no_compile <CR>", {
  desc = "Run test cases",
})
-- move current line
map("n", "<A-j>", "<cmd> m +1 <CR>", {
  desc = "move current line",
})
map("n", "<A-k>", "<cmd> m -2 <CR>", {
  desc = "move current line",
})

-- selection
map("x", "<A-j>", ":move '>+1<CR>gv-gv", {
  desc = "move selected line",
})
map("x", "<A-k>", ":move '<-2<CR>gv-gv", {
  desc = "move selected line",
})

map("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
  end)
  return "<Ignore>"
end, { desc = "Jump to next hunk", expr = true })

map("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
  end)
  return "<Ignore>"
end, { desc = "Jump to prev hunk", expr = true })

map("n", "<leader>td", function()
  require("gitsigns").toggle_deleted()
end, { desc = "Toggle deleted" })

-- run last command
map("n", "<C-b>", function()
  local nvterm = require "nvchad.term"
  nvterm.runner { pos = "sp", id = "htoggleTerm", cmd = "fc -s" }
end, {
  desc = "Run the last command in the current terminal",
})

-- paste
map("i", "<C-v>", '<esc>"+pi', { desc = "Paste from clipboard" })

-- Resenters screen after jumping (Note scrol down add 1 line to correct for navic)
map("n", "<C-d>", "<C-d>zz<C-y>", { desc = "Jump Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Jump Half page up" })

-- npm
map(
  "n",
  "<leader>np",
  require("package-info").change_version,
  { silent = true, noremap = true, desc = "Show package versions" }
)
vim.keymap.set(
  { "n" },
  "<LEADER>nu",
  require("package-info").update,
  { silent = true, noremap = true, desc = "Update package" }
)

-- terminal
map("t", "<C-k>", "<C-\\><C-N><C-w><C-w>", {
  desc = "Window prev",
})

local unmap = vim.keymap.del

unmap("n", "<leader>e")
unmap("n", "<tab>")
unmap("n", "<S-tab>")
unmap("t", "<Esc>")
