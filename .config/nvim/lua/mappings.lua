require "nvchad.mappings"

local unmap = vim.keymap.del

unmap("n", "<leader>e")
unmap("n", "<tab>")
unmap("n", "<S-tab>")
unmap("n", "gc")
unmap("n", "<leader>n")

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
  require("conform").format { async = false, lsp_fallback = true }
end, { desc = "File Format with conform" })

-- telescope
map("n", "<leader>fg", "<cmd> Telescope git_files <CR>", { desc = "Search git files" })
map("n", "<leader>fp", "<cmd> Telescope project <CR>", { desc = "Search projects" })
map("n", "<leader><leader>", "<cmd> Telescope resume <CR>", { desc = "Telescope Resume" })

local live_grep_in_glob = function(glob_pattern)
  if not glob_pattern or glob_pattern == "" then
    return
  end
  require("telescope.builtin").live_grep {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--hidden",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--glob=" .. glob_pattern,
    },
  }
end
map("n", "<leader>fw", function()
  vim.ui.input({ prompt = "Glob: ", completion = "file", default = "**/*" }, live_grep_in_glob)
end, { desc = "Grep args" })

-- zoxide
map("n", "<leader>z", "<cmd> Telescope zoxide list <CR>", { desc = "Zoxide list" })
-- toggle lsp
map("n", "<leader>ls", "<cmd> LspStart <CR>", { desc = "Start lsp" })
map("n", "<leader>lS", "<cmd> LspStop <CR>", { desc = "Stop lsp" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "lsp prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "lsp next diagnostic" })
map("n", "<leader>li", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = vim.api.nvim_get_current_buf() })
end, { desc = "Toggle inlay hints" })

-- quit
map("n", "<leader>Q", "<cmd>qall<CR>", { desc = "Quit all" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
-- neogit
map("n", "<leader>gs", "<cmd>Neogit<CR>", { desc = "Open neogit" })
-- move buffers
map("n", "L", function()
  require("nvchad.tabufline").next()
end, { desc = "Goto next buffer" })
map("n", "H", function()
  require("nvchad.tabufline").prev()
end, { desc = "Goto prev buffer" })
for i = 1, 4, 1 do
  map("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

-- trouble
map("n", "<leader>lt", "<cmd>Trouble diagnostics<CR>", { desc = "Toggle trouble" })

-- close all buffers
map("n", "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "Close all buffers" })

-- competetive coding
map("n", "<leader>rr", "<cmd> CompetiTest run <CR>", { desc = "Compile and run test cases" })
map("n", "<leader>rc", "<cmd> CompetiTest run_no_compile <CR>", { desc = "Run test cases" })
-- move current line
map("n", "<A-j>", "<cmd> m +1 <CR>", { desc = "move current line" })
map("n", "<A-k>", "<cmd> m -2 <CR>", { desc = "move current line" })

-- selection
map("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "move selected line" })
map("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "move selected line" })

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
map("n", "<leader>rh", function()
  require("gitsigns").reset_hunk()
end, { desc = "Toggle deleted" })

-- run last command
map("n", "<C-b>", function()
  local nvterm = require "nvchad.term"
  vim.cmd "write"
  nvterm.runner { pos = "sp", id = "htoggleTerm", cmd = "fc -s" }
end, { desc = "Run the last command in the current terminal" })

-- paste
map("i", "<C-v>", "<c-r>+", { desc = "Paste from clipboard" })
map({ "n", "x", "v" }, "<A-c>", '"+', { desc = "Use the system clipboard" })

-- Resenters screen after jumping (Note scrol down add 1 line to correct for navic)
map("n", "<C-d>", "<C-d>zz<C-y>", { desc = "Jump Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Jump Half page up" })

-- npm
map(
  "n",
  "<leader>pn",
  require("package-info").change_version,
  { silent = true, noremap = true, desc = "Show package versions" }
)

map("n", "<leader>pu", require("package-info").update, { silent = true, noremap = true, desc = "Update package" })

-- movement
map({ "n", "x" }, "j", "gj", { silent = true })
map({ "n", "x" }, "k", "gk", { silent = true })

-- toggle line wrapping
map("n", "<A-z>", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })
-- terminal
map("t", "<C-k>", "<C-\\><C-N><C-w><C-w>", { desc = "Window prev" })

-- LLM
map("n", "<leader>ll", "<cmd>LLM<CR>", { desc = "Prompt with LLM" })

-- keybinds for prompting with groq
map("n", "<leader>,", function()
  require("llm").prompt { replace = false, service = "groq" }
end, { desc = "Prompt with ai" })
map("v", "<leader>,", function()
  require("llm").prompt { replace = false, service = "groq" }
end, { desc = "Prompt with ai" })
map("v", "<leader>.", function()
  require("llm").prompt { replace = true, service = "groq" }
end, { desc = "Prompt while replacing with ai" })

-- keybinds to support vim motions
map("n", "g,", function()
  require("llm").prompt_operatorfunc { replace = false, service = "groq" }
end)
map("n", "g.", function()
  require("llm").prompt_operatorfunc { replace = true, service = "groq" }
end)

if vim.g.neovide == true then
  map("n", "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", { silent = true })
  map("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", { silent = true })
  map("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end

local preferred_fonts = {
  "DM Mono",
  "Berkeley Mono",
  "Iosevka Term",
  "Zed Mono",
  "Victor Mono", -- use the semibold vaiant
  "PragmataPro",
  "Input",
}

local function cycle_gui_font()
  local current_font = vim.o.guifont
  local current_index = 1
  for i, font in ipairs(preferred_fonts) do
    if font == current_font then
      current_index = i
      break
    end
  end
  vim.o.guifont = preferred_fonts[(current_index % #preferred_fonts) + 1]
  print("GUI font set to: " .. vim.o.guifont)
end

map("n", "<leader>F", cycle_gui_font, { desc = "Cycle GUI font" })
map("n", "<leader>no", function()
  require("notion").openMenu()
end)


function Invert(calledFromVisual)
  local antonyms = { "true", "false", "after", "before", "start", "end", "left", "right", "first", "last", "True", "False", "After", "Before", "Start", "End", "Left", "Right", "First", "Last", }
  if calledFromVisual then
    vim.cmd 'normal! gv"wy'
  else
    vim.cmd 'normal! "wyiw'
  end

  local wordUnderCaret = vim.fn.getreg "w"
  local eraseWord = calledFromVisual and "gvc" or "ciw"

  for count = 1, #antonyms do
    if antonyms[count] == wordUnderCaret then
      local antonym
      if count % 2 == 1 then
        antonym = antonyms[count + 1]
      else
        antonym = antonyms[count - 1]
      end
      vim.cmd("normal! " .. eraseWord .. antonym)
      break
    end
  end
end

map("n", "!", function()
  Invert(false)
end, { noremap = true, silent = true })

map("v", "!", function()
  Invert(true)
end, { noremap = true, silent = true })

