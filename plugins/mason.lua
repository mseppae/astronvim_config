-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with package installations.
    log_level = vim.log.levels.INFO,
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      -- Use the lspconfig names from here: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
      ensure_installed = {
        "eslint",
        "gopls",
        "lua_ls",
        "tailwindcss",
        "tsserver",
        "solargraph",
        "sorbet",
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "goimports-reviser",
        "prettierd",
        "stylua",
        "eslint_d",
        "haml-lint",
      },
      automatic_installation = {
        exclude = {
          "rubocop",
        },
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      -- ensure_installed = { "python" },
    },
  },
}
