return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "lua", "ruby", "javascript", "typescript", "go", "rust" },
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
      end
    },
  },
}
