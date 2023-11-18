-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },
}

---@type HLTable
M.add = {
  CursorLineNr = { bg = "statusline_bg", fg = "nord_blue" },
  NeogitDiffDelete = { bg = "NONE", fg = "baby_pink" },
  NeogitDiffDeleteHighlight = { bg = "NONE", fg = "red" },
}

return M
