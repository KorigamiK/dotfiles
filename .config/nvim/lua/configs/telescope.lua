return {
  extensions_list = { "themes", "terms", "project", "zoxide", "live_grep_args" },
  defaults = {
    file_ignore_patterns = { "node_modules/", ".git/", ".cache/", ".venv/" },
  },
  pickers = {
    find_files = { hidden = true },
    git_files = { show_untracked = true, wrap_results = true },
  },
  extensions = {
    project = {
      base_dirs = {
        { "~/Dev/projects", max_depth = 4 },
        { "~/Dev/docs" },
        { "~/Dev/CV" },
      },
      sync_with_nvim_tree = true,
      order_by = "recent",
      hidden_files = true,
    },
    zoxide = {
      prompt_title = "[ Walk to your path ]",
      mappings = {
        default = {
          after_action = function(selection)
            vim.notify(
              "Changed to " .. selection.path .. " (" .. selection.z_score .. ")",
              vim.log.levels.INFO,
              { title = "Zoxide updated tab path" }
            )
            require("telescope.builtin").find_files()
          end,
        },
      },
    },
  },
}
