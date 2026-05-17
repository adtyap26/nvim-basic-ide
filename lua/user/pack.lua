-- vim.pack experiment (Neovim 0.12+ built-in package manager)
-- Plugins here are managed by vim.pack, not lazy.nvim
vim.pack.add({
  {
    src = "https://github.com/mcauley-penney/visual-whitespace.nvim",
    name = "visual-whitespace.nvim",
  },
}, { confirm = false })

-- config for visual-whitespace
require("visual-whitespace").setup({
  highlight = { link = "Visual" },
  space_char = "·",
  tab_char = "→",
  nl_char = "↲",
  cr_char = "←",
})
