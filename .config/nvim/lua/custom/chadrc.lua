---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "chadracula",
  lsp_semantic_tokens = true,

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    theme = "default",
    separator_style = "block",
    overriden_modules = function(modules)
      local m = vim.api.nvim_get_mode().mode
      local st_modules = require "nvchad.statusline.default"
      modules[1] = "%#" .. st_modules.modes[m][2] .. "#" .. " " .. st_modules.modes[m][1] .. " "
    end,
  },

  tabufline = {
    overriden_modules = function(modules)
      table.remove(modules, 1)
      table.remove(modules, 3)
    end,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
