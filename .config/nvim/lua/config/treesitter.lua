local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
      "bash",
      "cpp",
      "css",
      "go",
      "html",
      "lua",
      "make",
      "python",
      "rust",
      "tsx",
      "typescript",
      "yaml",
    },

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },
  }
end

return M
