---@type ChadrcConfig
local M = {}

local highlights = require "highlights"

M.ui = {

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

M.base46 = {
  integrations = { "trouble" },
  theme = "kanagawa",
  transparency = false,

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.mason = {
  pkgs = {
    "lua-language-server",
    "stylua",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "astro-language-server",
    "tailwindcss-language-server",
    "shfmt",
    "black",
    "isort",
    "nomicfoundation-solidity-language-server",
    "tree-sitter-cli",
    "taplo",
    "json-lsp",
    "ruff",
    'zls'
  },
}

return M
