return {
  "jose-elias-alvarez/null-ls.nvim",
  -- debug = true,
  -- NOTE: So that I remember next time why things are where they are:
  -- We need to setup rubocop here. This is because we use solargraph for LSP.
  -- But solargraph is way too slow for formatting and diagnostics.
  -- lsp.config.solargraph is explicitly saying not to format or to do diagnostics.
  -- mason-null-ls is explicitly not allowing another rubocop install to duplicate things,
  -- since it also considered as lsp it can at worst give same warning three times.
  -- There are still many assumptions of whats actually happening, but now this seems to work for ruby projects
  -- with Gemfile and without. Lets see how long until I realize there was yet another variable annoying me
  -- lets hope not.
  opts = function(_, config)
    local null_ls = require "null-ls"

    local conditional = function(fn)
      local utils = require("null-ls.utils").make_conditional_utils()
      return fn(utils)
    end

    local rubocop_formatting_args = {
      -- Change from -a to -A, not sure of this though, I would just want that FrozenStringLiteral cop
      -- "-A",
      "-a",
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
