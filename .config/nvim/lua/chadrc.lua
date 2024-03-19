---@type ChadrcConfig
local M = {}

local highlights = require "highlights"

M.ui = {
  theme = "kanagawa",
  transparency = false,
  lsp_semantic_tokens = true,

  hl_override = highlights.override,
  hl_add = highlights.add,

  cmp = {
    style = "default",
    icons = true,
    selected_item_bg = "simple",
  },

  tabufline = { order = { "buffers", "tabs" } },

  statusline = {
    theme = "vscode_colored",
    modules = {
      mode = function()
        local utils = require "nvchad.stl.utils"
        if not utils.is_activewin() then
          return ""
        end

        local modes = utils.modes
        local m = vim.api.nvim_get_mode().mode
        return "%#St_" .. modes[m][2] .. "mode# " .. modes[m][1] .. " "
      end,
    },
  },
}


return M
