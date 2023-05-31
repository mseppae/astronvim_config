return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "lua", "ruby", "javascript", "typescript", "go", "rust" },
    incremental_selection = {
      keymaps = {
        init_selection = "<CR>",
        node_decremental = "<S-TAB>",
        node_incremental = "<TAB>",
        scope_incremental = "<CR>",
      },
    },
  },
  dependencies = {
    {
      "RRethy/nvim-treesitter-endwise",
      config = function()
        require("nvim-treesitter.configs").setup {
          endwise = {
            enable = true,
          },
        }
      end,
    },
  },
}
