return {
  extensions_list = { "themes", "terms", "project", "zoxide", "live_grep_args" },
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", ".cache" },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
    live_grep = {
      file_ignore_patterns = { "node_modules", ".git", ".venv" },
      additional_args = function(_)
        return { "--hidden", "--with-filename" }
      end,
    },
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
    live_grep_args = {
      auto_quoting = false,
      mappings = {
        i = {
          ["<C-k>"] = function(n)
            require("telescope-live-grep-args.actions").quote_prompt()(n)
          end,
          ["<C-t>"] = function(_)
            require("telescope-live-grep-args.actions").quote_prompt { postfix = " -t " }(_)
          end,
        },
      },
    },
  },
}
