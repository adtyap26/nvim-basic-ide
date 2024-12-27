local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup {
  {
    "folke/tokyonight.nvim",
    commit = "e52c41314e83232840d6970e6b072f9fba242eb9",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require "user.colorscheme"
    end,
  },
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      vim.o.termguicolors = true
      vim.o.background = "dark"
      require("solarized").setup(opts)
      vim.cmd.colorscheme "solarized"
    end,
  },
  {
    "simrat39/inlay-hints.nvim",
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },
  -- {
  --   "stevearc/conform.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     local conform = require "conform"
  --     conform.setup {
  --       formatters_by_ft = {
  --         go = { "gofumpt" },
  --         lua = { "stylua" },
  --         yaml = { "yamlfmt" },
  --         markdown = { "prettier" },
  --         json = { "prettier" },
  --         python = { "isort", "black" },
  --         C = { "clang-format" },
  --       },
  --       format_on_save = {
  --         -- I recommend these options. See :help conform.format for details.
  --         lsp_fallback = true,
  --         async = false,
  --         timeout_ms = 500,
  --       },
  --       log_level = vim.log.levels.ERROR,
  --       -- Conform will notify you when a formatter errors
  --       notify_on_error = true,
  --       -- Custom formatters and changes to built-in formatters
  --     }
  --     vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  --       conform.format {
  --         lsp_fallback = true,
  --         async = false,
  --         timeout_ms = 500,
  --       }
  --     end, { desc = "Format file or range (in visual mode)" })
  --   end,
  -- },
  -- {
  --   "mfussenegger/nvim-lint",
  --   event = {
  --     "BufReadPre",
  --     "BufNewFile",
  --   },
  --   config = function()
  --     local lint = require "lint"
  --
  --     lint.linters_by_ft = {
  --       yaml = { "yamllint" },
  --       markdown = { "markdownlint" },
  --     }
  --     local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  --
  --     vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  --       group = lint_augroup,
  --       callback = function()
  --         lint.try_lint()
  --       end,
  --     })
  --     vim.keymap.set("n", "<leader>ln", function()
  --       lint.try_lint()
  --     end, { desc = "Trigger linting for current file" })
  --   end,
  -- },
  --   {
  --   'Exafunction/codeium.vim',
  --   config = function ()
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  --   end
  -- },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = ...,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    commit = "8299fe7703dfff4b1752aeed271c3b95281a952d",
    event = "BufReadPre",
    config = function()
      require "user.indentline"
    end,
  },
  {
    "folke/which-key.nvim",
    commit = "5224c261825263f46f6771f1b644cae33cd06995",
    event = "VeryLazy",
    config = function()
      -- require "user.whichkey"
    end,
  },
  {
    "mcauley-penney/visual-whitespace.nvim",
    config = true,
    opts = {
      highlight = { link = "Visual" },
      space_char = "·",
      tab_char = "→",
      nl_char = "↲",
      cr_char = "←",
    },
  },
  { "nvim-lua/plenary.nvim", commit = "9a0d3bf7b832818c042aaf30f692b081ddd58bd9", lazy = true },
  {
    "windwp/nvim-autopairs",
    commit = "0e065d423f9cf649e1d92443c939a4b5073b6768",
    event = "InsertEnter",
    config = function()
      require "user.autopairs"
    end,
  },
  {
    "numToStr/Comment.nvim",
    commit = "eab2c83a0207369900e92783f56990808082eac2",
    event = "BufRead",
    config = function()
      require "user.comment"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- commit = "d3a68725e8349212a359d1914fc6e86ff31e4142",
    event = "BufReadPost",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
        commit = "a0f89563ba36b3bacd62cf967b46beb4c2c29e52",
      },
      {
        "kyazdani42/nvim-web-devicons",
        config = function()
          require("nvim-web-devicons").setup {
            override = {
              zsh = {
                icon = "",
                color = "#428850",
                cterm_color = "65",
                name = "Zsh",
              },
            },
            color_icons = true,
            default = true,
          }
        end,
      },
    },
    config = function()
      require "user.treesitter"
    end,
  },
  {
    "DaikyXendo/nvim-material-icon",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
  {
    "kyazdani42/nvim-tree.lua",
    commit = "59e65d88db177ad1e6a8cffaafd4738420ad20b6",
    config = function()
      require "user.nvim-tree"
    end,
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      require "user.bufferline"
    end,
  },
  {
    "moll/vim-bbye",
    commit = "25ef93ac5a87526111f43e5110675032dbcacf56",
  },
  {
    "nvim-lualine/lualine.nvim",
    commit = "0050b308552e45f7128f399886c86afefc3eb988",
    config = function()
      require "user.lualine"
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    commit = "19aad0f41f47affbba1274f05e3c067e6d718e1e",
    event = "VeryLazy",
    config = function()
      require "user.toggleterm"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    -- commit = "203bf5609137600d73e8ed82703d6b0e320a5f36",
    event = "Bufenter",
    cmd = { "Telescope" },
    dependencies = {
      {
        "ahmedkhalf/project.nvim",
        -- commit = "685bc8e3890d2feb07ccf919522c97f7d33b94e4",
        config = function()
          require "user.project"
        end,
      },
    },
    config = function()
      require "user.telescope"
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require "user.alpha"
    end,
  },
  {
    "lunarvim/darkplus.nvim",
    commit = "1826879d9cb14e5d93cd142d19f02b23840408a6",
  },
  {
    "hrsh7th/nvim-cmp",
    commit = "cfafe0a1ca8933f7b7968a287d39904156f2c57d",
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp",
      },
      {
        "hrsh7th/cmp-buffer",
      },
      {
        "hrsh7th/cmp-path",
      },
      {
        "hrsh7th/cmp-cmdline",
      },
      {
        "saadparwaiz1/cmp_luasnip",
      },
      {
        "hrsh7th/cmp-nvim-lua",
      },
    },
    config = function()
      require "user.cmp"
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    commit = "9bff06b570df29434a88f9c6a9cea3b21ca17208",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      commit = "a6f7a1609addb4e57daa6bedc300f77f8d225ab7",
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
  },
  {
    "williamboman/mason.nvim",
    commit = "4546dec8b56bc56bc1d81e717e4a935bc7cd6477",
    cmd = "Mason",
    event = "BufReadPre",
    config = function()
      require "user.lsp.mason"
    end,
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    commit = "60b4a7167c79c7d04d1ff48b55f2235bf58158a7",
    config = function()
      require "user.lsp.null-ls"
    end,
  },

  {
    "RRethy/vim-illuminate",
    commit = "d6ca7f77eeaf61b3e6ce9f0e5a978d606df44298",
    event = "VeryLazy",
    config = function()
      require "user.illuminate"
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    commit = "ec4742a7eebf68bec663041d359b95637242b5c3",
    event = "BufReadPre",
    config = function()
      require "user.gitsigns"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    commit = "6b12294a57001d994022df8acbe2ef7327d30587",
    event = "VeryLazy",
    config = function()
      require "user.dap"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13",
    event = "VeryLazy",
    config = function()
      require "user.dapui"
    end,
  },
  {
    "ravenxrz/DAPInstall.nvim",
    commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de",
    lazy = true,
    config = function()
      require("dap_install").setup {}
      require("dap_install").config("python", {})
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      {
        "mfussenegger/nvim-dap",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },

  {
    "chrisgrieser/nvim-genghis",
    dependencies = {
      {
        "stevearc/dressing.nvim",
      },
    },
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require "user.colorizer"
    end,
  },
  {
    "ray-x/go.nvim",
    requires = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "ray-x/guihua.lua",
    config = function()
      require "user.guihua"
    end,
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
        },
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = false,
          font = "+4", -- font size increment
        },
        -- this will change the font size on alacritty when in zen mode
        -- requires  Alacritty Version 0.10.0 or higher
        -- uses `alacritty msg` subcommand to change font size
        alacritty = {
          enabled = false,
          font = "14", -- font size
        },
        -- this will change the font size on wezterm when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        wezterm = {
          enabled = false,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win) end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function() end,
    },
  },
}
