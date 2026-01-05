local colorscheme = "solarized"

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  return
end

-- Custom highlights for LSP floating windows (hover, signature help, etc.)
-- High contrast colors for better readability
vim.api.nvim_set_hl(0, "NormalFloat", {
  bg = "#93c572",  -- Dark background (Solarized base02) - high contrast with main editor
  fg = "#242424",  -- Light text (Solarized base3)
})

vim.api.nvim_set_hl(0, "FloatBorder", {
  bg = "#93c572",  -- Match float background
  fg = "#cb4b16",  -- Bright orange border (Solarized orange) - very visible
  bold = true,
})

vim.api.nvim_set_hl(0, "FloatTitle", {
  bg = "#cb4b16",  -- Orange background for title
  fg = "#242424",  -- Light text
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
  bg = "#eee8d5",  -- Medium gray (base1)
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
  fg = "#eee8d5",  -- Medium gray for text
})

vim.api.nvim_set_hl(0, "CmpItemKindSnippet", {
  fg = "#d33682",  -- Magenta for snippets
  bold = true,
})

-- Completion menu source indicator
vim.api.nvim_set_hl(0, "CmpItemMenu", {
  fg = "#eee8d5",  -- Light gray
  italic = true,
})

-- Telescope colors - match Solarized light theme
-- Main window background
vim.api.nvim_set_hl(0, "TelescopeNormal", {
  bg = "#fdf6e3",  -- Light background (same as editor)
  fg = "#073642",  -- Dark text
})

-- Border colors - visible with Solarized blue
vim.api.nvim_set_hl(0, "TelescopeBorder", {
  bg = "#fdf6e3",  -- Match background
  fg = "#268bd2",  -- Blue border - visible and matching theme
})

-- Preview window
vim.api.nvim_set_hl(0, "TelescopePreviewNormal", {
  bg = "#fdf6e3",
  fg = "#073642",
})

vim.api.nvim_set_hl(0, "TelescopePreviewBorder", {
  bg = "#fdf6e3",
  fg = "#268bd2",  -- Blue border
})

-- Results window
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", {
  bg = "#fdf6e3",
  fg = "#073642",
})

vim.api.nvim_set_hl(0, "TelescopeResultsBorder", {
  bg = "#fdf6e3",
  fg = "#268bd2",  -- Blue border
})

-- Prompt window
vim.api.nvim_set_hl(0, "TelescopePromptNormal", {
  bg = "#eee8d5",  -- Slightly darker for distinction
  fg = "#073642",
})

vim.api.nvim_set_hl(0, "TelescopePromptBorder", {
  bg = "#eee8d5",
  fg = "#268bd2",  -- Blue border
})

-- Selected item
vim.api.nvim_set_hl(0, "TelescopeSelection", {
  bg = "#eee8d5",  -- Gray background for selected item
  fg = "#073642",
  bold = true,
})

-- Title
vim.api.nvim_set_hl(0, "TelescopeTitle", {
  bg = "#268bd2",  -- Blue
  fg = "#fdf6e3",
  bold = true,
})

-- Spell checking - use underline instead of strikethrough for readability
-- Misspelled words
vim.api.nvim_set_hl(0, "SpellBad", {
  undercurl = true,  -- Wavy underline
  sp = "#dc322f",    -- Red color for the underline
})

-- Words that should start with capital
vim.api.nvim_set_hl(0, "SpellCap", {
  undercurl = true,
  sp = "#268bd2",    -- Blue underline
})

-- Rare words
vim.api.nvim_set_hl(0, "SpellRare", {
  undercurl = true,
  sp = "#d33682",    -- Magenta underline
})

-- Words from another region (wrong locale)
vim.api.nvim_set_hl(0, "SpellLocal", {
  undercurl = true,
  sp = "#2aa198",    -- Cyan underline
})
