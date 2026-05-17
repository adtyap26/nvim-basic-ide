if vim.deprecate ~= nil then
  vim.deprecate = function() end
end

require "user.options"
require "user.keymaps"
require "user.pack"
require "user.lazy"
require "user.treesitter"
require "user.snippets"
require "user.autocommands"
require "user.lsp"
require "user.colorscheme"
-- vim.cmd("colorscheme tokyonight-night")
