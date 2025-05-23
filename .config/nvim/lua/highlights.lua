-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = { italic = true },
  ["@comment"] = { fg = "nord_blue" },
  Boolean = { italic = true },
  Conditional = { italic = true, bold = true },
  Repeat = { italic = true },
  Include = { italic = true },
  ["@keyword.return"] = { italic = true },
  ["@keyword.operator"] = { italic = true },
  ["@keyword.function"] = { italic = true },
  ["@exception"] = { italic = true },
  ["@include"] = { italic = true },
  ["@repeat"] = { italic = true },
  ["@boolean"] = { italic = true },
  TelescopePromptNormal = { blend = 100 },
  TelescopePromptBorder = { fg = "pink" },
  -- ["@string"] = { italic = true },
  -- TelescopeBorder = { fg = "blue" },
  LazyButton = { fg = "white", bg = "black" }
}

---@type HLTable
M.add = {
  IndentBlanklineContextStart = { bg = "black2" },
  NeogitDiffDeleteCursor = { bg = "NONE", fg = "red" },
  NeogitDiffDeleteHighlight = { bg = "NONE", fg = "red" },
  NeogitDiffDelete = { bg = "NONE", fg = "red" },
  NeogitChangeDeleted = { bg = "NONE", fg = "red" },
  -- TelescopeSelection = { bg = "red" },
  LspInlayHint = { bg = "NONE", fg = "light_grey" },
  IblWhitespace = { fg = "white" },
  -- Flat Floating
  -- NormalFloat = { fg = "white", bg = "darker_black", blend = 0 },
  -- FloatBorder = { fg = "darker_black", bg = "darker_black", blend = 5 },

  -- Nvim Tree
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
  ["@markup.math.latex"] = { fg = "vibrant_green" },
  ["@chat.user"] = { fg = "one_bg", bg = "vibrant_green" },
}

return M
