local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local action_layout = require "telescope.actions.layout"

telescope.setup {
  defaults = {

    preview = false,

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<M-p>"] = action_layout.toggle_preview,
      },
      n = {
        ["<M-p>"] = action_layout.toggle_preview,
      },
    },
  },
}
