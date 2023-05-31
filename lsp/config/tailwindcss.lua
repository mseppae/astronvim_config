-- Credit https://github.com/liaden/dotfiles/blob/master/.config/nvim/lua/lsp-config.lua#L107
return {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = { -- for haml :D
          "%\\w+([^\\s]*)",
          "\\.([^\\.]*)",
          ':class\\s*=>\\s*"([^"]*)',
          'class:\\s+"([^"]*)',
        },
      },
    },
  },
}
