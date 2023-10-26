local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

return {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        completion = {
          addCallArgumentSnippets = true,
          addCallParenthesis = true,
          enableExperimental = true,
          autoimport = { enable = true },
          postfix = { enable = false, true },
        },
        rustfmt = {
          extraArgs = {
            "--config",
            "imports_granularity=Crate,wrap_comments=true,comment_width=100,max_width=100,tab_spaces=2",
          },
        },
        cargo = {
          autoReload = true,
          loadOutDirsFromCheck = true,
          allFeatures = true,
        },
        checkOnsave = {
          enable = true,
          allFeatures = true,
        },
        hoverActions = {
          enable = true,
          references = true,
        },
        procMacro = { enable = true },
        inlayHints = { enable = true },
        lens = { enable = true },
        lruCapacity = 250,
        workspace = { symbol = { search = { kind = "all_symbols" } } },
      },
    },
  },
}
