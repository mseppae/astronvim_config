return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls_status_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_status_ok then return config end

    local rubocop_args = {
      "-A", --- Changed from -a to -A
      "-f",
      "quiet",
      "--stderr",
      "--stdin",
      "$FILENAME",
    }
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local conditional = function(fn)
      local utils = require("null-ls.utils").make_conditional_utils()
      return fn(utils)
    end

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      formatting.stylua,
      formatting.prettier,
      formatting.goimports,

      conditional(
        function(utils)
          return utils.root_has_file "Gemfile"
              and formatting.rubocop.with {
                command = "bundle",
                args = vim.list_extend({ "exec", "rubocop" }, rubocop_args),
              }
              or formatting.rubocop.with { args = rubocop_args}
        end
      ),

      conditional(
        function(utils)
          return utils.root_has_file "Gemfile"
              and diagnostics.rubocop.with {
                command = "bundle",
                args = vim.list_extend({ "exec", "rubocop" }, diagnostics.rubocop._opts.args),
              }
              or diagnostics.rubocop
        end
      ),
    }
    return config -- return final config table
  end,
}
