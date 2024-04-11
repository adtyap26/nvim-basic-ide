-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal mode --

--Basic Operations
keymap("n", "<leader>w", "<cmd>w<CR>", opts) --save
keymap("n", "<leader>q", "<cmd>q<CR>", opts) --quit
keymap("n", "<C-q>", "<cmd>q!<CR>", opts) --force quit without save
-- keymap("n", "dd", '"_d', opts)
-- keymap("v", "d", '"_d', opts)
-- keymap("v", "p", '"_dP', opts)
keymap("n", "<leader>cd", "<cmd>cd %:p:h<CR>", opts) --change root directory

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--split
keymap("n", "<leader>sv", "<C-w>v") --  split window vertically
keymap("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap("n", "<leader>sx", ":close<CR>") -- close split

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Treesitter context jumping
keymap("n", "[c", function()
  require("treesitter-context").go_to_context()
end, { silent = true })


-- Better paste
-- keymap("v", "p", '"_dP', opts)
keymap("n", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', opts) -- paste without replaced by a cut
keymap("n", "x", '"_x') --Dont need to save for deleting something with x

--incrementing numbers
keymap("n", "<S-+>", "<C-a>")
keymap("n", "<S-->", "<C-x>")

-- pandoc command_mode
keymap("n", "<leader>pf", '<cmd>!pandoc --pdf-engine=weasyprint $* "%" -f markdown -t pdf -s -o "%:r".pdf<CR>', opts) -- md to pdf (use source py env first)

-- Insert Mode --

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual mode --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --
-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "[F]ind [F]iles" })
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "[F]ind by [G]rep" })
keymap("n", "<leader>ht", ":Telescope help_tags<CR>", { desc = "[S]earch [H]elp" })
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fs", ":Telescope grep_string<CR>", { desc = "[F]ind current [S]tring" })
keymap("n", "<leader>s", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    windblend = 10,
    previewer = false,
  })
end, { desc = "[s] Fuzzily search in current buffer" })
keymap("n", "<leader>fd", ":Telescope lsp_definitions<CR>", { desc = "[L]sp [D]efinitions" })

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- nvim-genghis

keymap("n", "<leader>yp", ":CopyFilepath<CR>", { desc = "[C]opy [P]ath" })
keymap("n", "<leader>yn", ":CopyFilename<CR>", { desc = "[C]opy [F]ilename" })
keymap("n", "<leader>cx", ":Chmodx<CR>", { desc = "[F]ile [E]xecuteable" })
keymap("n", "<leader>rf", ":RenameFile<CR>", { desc = "[R]enaming [F]ilename" })
keymap("n", "<leader>nf", ":CreateNewFile<CR>", { desc = "[C]reating a [N]ewfile" })
keymap("n", "<leader>yf", ":DuplicateFile<CR>", { desc = "[D]uplicating a [F]ile" })
keymap("x", "<leader>x", ":MoveSelectionToNewFile<CR>", { desc = "[M]oving to a [N]ewfile" })

--Terminal

keymap("n", "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", opts)
keymap("n", "<leader>tv", "<cmd>ToggleTerm size=60 direction=vertical<cr>", opts)

--Custom Terminal
-- lazyGit
keymap("n", "<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- LazyDocker
keymap("n", "<leader>ld", "<cmd>lua _LAZYDOCKER_TOGGLE()<CR>", opts)
