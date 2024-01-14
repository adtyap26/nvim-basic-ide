local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback
local gheight = vim.api.nvim_list_uis()[1].height
local gwidth = vim.api.nvim_list_uis()[1].width
local width = 100
local height = 30

nvim_tree.setup({
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	renderer = {
		root_folder_modifier = ":t",
		icons = {
			glyphs = {
				default = " ",
				symlink = " ",
				folder = {
					arrow_open = " ",
					arrow_closed = " ",
					default = " ",
					open = " ",
					empty = " ",
					empty_open = " ",
					symlink = " ",
					symlink_open = " ",
				},
				git = {
					unstaged = " ",
					staged = "S ",
					unmerged = " ",
					renamed = "➜ ",
					untracked = "U",
					deleted = " ",
					ignored = "◌ ",
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = " ",
			info = " ",
			warning = " ",
			error = " ",
		},
	},
	view = {
		float = {
			enable = true,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = width,
				height = height,
				row = (gheight - height) * 0.5,
				col = (gwidth - width) * 0.5,
			},
		},
		-- width = 100,
		-- side = "left",
		mappings = {
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
	},
})
