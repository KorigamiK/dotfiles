---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "kanagawa",

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    theme = "default",
    separator_style = "block",
    overriden_modules = function()
      local st_modules = require "nvchad_ui.statusline.default"
      return {
        mode = function()
          local m = vim.api.nvim_get_mode().mode
          return "%#" .. st_modules.modes[m][2] .. "#" .. " " .. st_modules.modes[m][1] .. " "
        end
      }
    end
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
