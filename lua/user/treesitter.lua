-- Built-in treesitter (no nvim-treesitter plugin)
-- Parsers + queries are in ~/.local/share/nvim/site/

-- Register custom directives that were previously provided by nvim-treesitter
vim.treesitter.query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
  local capture_id = pred[2]
  local node = match[capture_id]
  if not node then return end
  -- Neovim 0.12: match[capture_id] may return a list
  if type(node) == "table" then node = node[1] end
  if not node then return end
  local text = vim.treesitter.get_node_text(node, bufnr)
  metadata[capture_id] = metadata[capture_id] or {}
  metadata[capture_id].text = text:lower()
end, { force = true })

local filetypes = {
  "bash", "css", "dockerfile", "go", "html",
  "javascript", "json", "lua", "markdown", "markdown_inline",
  "python", "rust", "tsx", "typescript", "vim", "yaml",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
