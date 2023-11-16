return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, config)
    local ensure_installed_extensions = { "lua", "ruby", "javascript", "typescript", "go" }
    local config_replacements = {
      incremental_selection = {
        keymaps = {
          init_selection = "<CR>",
          node_decremental = "<S-TAB>",
          node_incremental = "<TAB>",
          scope_incremental = "<CR>",
        },
      },
      endwise = {
        enable = true
      }
    }
    -- Mutate the list by adding our preferences and keeping the defaults
    vim.list_extend(config.ensure_installed, ensure_installed_extensions)
    -- Merge our replacements to main config
    local modified_config = vim.tbl_deep_extend("force", config, config_replacements)
    return modified_config
  end,
  dependencies = {
    {
      "RRethy/nvim-treesitter-endwise",
    },
  },
}
