---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "doomchad",
  lsp_semantic_tokens = true,

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    theme = "default",
    separator_style = "block",
    overriden_modules = function(modules)
      local m = vim.api.nvim_get_mode().mode
      local st_modules = require "nvchad_ui.statusline.default"
      modules[1] = "%#" .. st_modules.modes[m][2] .. "#" .. " " .. st_modules.modes[m][1] .. " "
    end,
  },

  tabufline = {
    overriden_modules = function(modules)
      modules[4] = ""
    end,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

vim.g.nvimtree_side = "right"

return M
