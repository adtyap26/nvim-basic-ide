local colorscheme = "solarized"

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  return
end

-- Custom highlights for LSP floating windows (hover, signature help, etc.)
-- High contrast colors for better readability
vim.api.nvim_set_hl(0, "NormalFloat", {
  bg = "#073642",  -- Dark background (Solarized base02) - high contrast with main editor
  fg = "#fdf6e3",  -- Light text (Solarized base3)
})

vim.api.nvim_set_hl(0, "FloatBorder", {
  bg = "#073642",  -- Match float background
  fg = "#cb4b16",  -- Bright orange border (Solarized orange) - very visible
  bold = true,
})

vim.api.nvim_set_hl(0, "FloatTitle", {
  bg = "#cb4b16",  -- Orange background for title
  fg = "#fdf6e3",  -- Light text
  bold = true,
})

-- Completion menu (nvim-cmp) colors - Light theme with high contrast border
-- Main popup menu - light background with darker border for contrast
vim.api.nvim_set_hl(0, "Pmenu", {
  bg = "#fdf6e3",  -- Light background (Solarized base3 - brightest)
  fg = "#073642",  -- Dark text (Solarized base02)
})

-- Selected item in completion menu - bright color for visibility
vim.api.nvim_set_hl(0, "PmenuSel", {
  bg = "#268bd2",  -- Blue background for selected item
  fg = "#fdf6e3",  -- Light text
  bold = true,
})

-- Scrollbar background
vim.api.nvim_set_hl(0, "PmenuSbar", {
  bg = "#eee8d5",  -- Light gray (base2)
})

-- Scrollbar thumb
vim.api.nvim_set_hl(0, "PmenuThumb", {
  bg = "#93a1a1",  -- Medium gray (base1)
})

-- Matching text in completion items (the part you typed) - bright red
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {
  fg = "#dc322f",  -- Red - very visible on light background
  bold = true,
})

vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {
  fg = "#dc322f",  -- Red
  bold = true,
})

-- Different completion item kinds with different colors
vim.api.nvim_set_hl(0, "CmpItemKindFunction", {
  fg = "#268bd2",  -- Blue for functions
  bold = true,
})

vim.api.nvim_set_hl(0, "CmpItemKindMethod", {
  fg = "#268bd2",  -- Blue for methods
  bold = true,
})

vim.api.nvim_set_hl(0, "CmpItemKindVariable", {
  fg = "#859900",  -- Green for variables
})

vim.api.nvim_set_hl(0, "CmpItemKindKeyword", {
  fg = "#cb4b16",  -- Orange for keywords
  bold = true,
})

vim.api.nvim_set_hl(0, "CmpItemKindText", {
  fg = "#586e75",  -- Medium gray for text
})

vim.api.nvim_set_hl(0, "CmpItemKindSnippet", {
  fg = "#d33682",  -- Magenta for snippets
  bold = true,
})

-- Completion menu source indicator
vim.api.nvim_set_hl(0, "CmpItemMenu", {
  fg = "#93a1a1",  -- Light gray
  italic = true,
})
