vim.o.background = "light"
vim.cmd.colorscheme "solarized"

-- Float
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#F8e2d9", fg = "#242424" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#F8e2d9", fg = "#cb4b16", bold = true })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#cb4b16", fg = "#242424", bold = true })

-- Completion menu
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#fdf6e3", fg = "#073642" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#268bd2", fg = "#fdf6e3", bold = true })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#eee8d5" })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#eee8d5" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#dc322f", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#dc322f", bold = true })
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#268bd2", bold = true })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#268bd2", bold = true })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#859900" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#cb4b16", bold = true })
vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#eee8d5" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#d33682", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#eee8d5", italic = true })

-- Telescope
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#fdf6e3", fg = "#073642" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#fdf6e3", fg = "#268bd2" })
vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#fdf6e3", fg = "#073642" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "#fdf6e3", fg = "#268bd2" })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#fdf6e3", fg = "#073642" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "#fdf6e3", fg = "#268bd2" })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#eee8d5", fg = "#073642" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "#eee8d5", fg = "#268bd2" })
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#eee8d5", fg = "#073642", bold = true })
vim.api.nvim_set_hl(0, "TelescopeTitle", { bg = "#268bd2", fg = "#fdf6e3", bold = true })

-- Spell
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#dc322f" })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = "#268bd2" })
vim.api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = "#d33682" })
vim.api.nvim_set_hl(0, "SpellLocal", { undercurl = true, sp = "#2aa198" })
