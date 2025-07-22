---@type ChadrcConfig
local M = {}

local highlights = require "highlights"

M.ui = {
  cmp = {
    style = "default",
    icons = true,
    selected_item_bg = "simple",
  },

  tabufline = {
    order = { "buffers", "tabs" },
    modules = {
      tabs = function()
        local result, tabs = "", vim.fn.tabpagenr "$"
        local btn = require("nvchad.tabufline.utils").btn
        if tabs > 1 then
          for nr = 1, tabs, 1 do
            local tab_hl = "TabO" .. (nr == vim.fn.tabpagenr() and "n" or "ff")
            result = result .. btn(" " .. nr .. " ", tab_hl, "GotoTab", nr)
          end
          return result
        end
        return ""
      end,
    },
  },

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
  integrations = { "trouble", "blink" },
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
    "zls",
  },
}

M.term = {
  winopts = { winfixbuf = true },
}

return M
