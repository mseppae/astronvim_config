return {
  "jose-elias-alvarez/null-ls.nvim",
  -- debug = true,
  -- NOTE: Assumption - Setup the formatters and linters that cannot be done with mason here.
  -- In case of rubocop it ended up running formatter and linter twice, since mason also installed it.
  -- Now it is excluded there and setup here (since we need to modify the arguments)
  opts = function(_, config)
    local null_ls = require "null-ls"

    local conditional = function(fn)
      local utils = require("null-ls.utils").make_conditional_utils()
      return fn(utils)
    end

    local rubocop_formatting_args = {
      -- Changed from -a to -A, not sure of this though, I just want that FrozenStringLiteral cop
      "-A",
      "-f",
      "quiet",
      "--stderr",
      "--stdin",
      "$FILENAME",
    }

    local rubocop_formatter_config = conditional(function(utils)
      if utils.root_has_file "Gemfile" then
        return {
          command = "bundle",
          args = vim.list_extend({ "exec", "rubocop" }, rubocop_formatting_args),
        }
      end
      return { args = rubocop_formatting_args }
    end)

    local rubocop_linter_config = conditional(function(utils)
      if utils.root_has_file "Gemfile" then
        return {
          command = "bundle",
          args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
        }
      end
      return {}
    end)

    config.sources = {
      null_ls.builtins.formatting.rubocop.with(rubocop_formatter_config),
      null_ls.builtins.diagnostics.rubocop.with(rubocop_linter_config),
    }

    return config
  end,
}
