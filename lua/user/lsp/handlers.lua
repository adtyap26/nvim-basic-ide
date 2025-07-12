local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  -- Only set up these handlers once to prevent duplicates
  if not M._handlers_setup then
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })

    M._handlers_setup = true
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "<leader>df", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>ma", "<cmd>Mason<cr>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  if client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end

  lsp_keymaps(bufnr)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

M.setup_clangd = function()
  local lspconfig = require "lspconfig"

  lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
      M.on_attach(client, bufnr)

      -- Add inlay hints with error handling
      if client.supports_method "textDocument/inlayHint" then
        pcall(function()
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end)
      end
    end,
    capabilities = M.capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    settings = {
      clangd = {
        InlayHints = {
          Designators = true,
          Enabled = true,
          ParameterNames = true,
          DeducedTypes = true,
        },
        fallbackFlags = { "-std=c++17" },
      },
    },
  }
end

M.setup_gopls = function()
  local lspconfig = require "lspconfig"
  local ih = require "inlay-hints"

  lspconfig.gopls.setup {
    on_attach = function(client, bufnr)
      M.on_attach(client, bufnr)
      ih.on_attach(client, bufnr)
    end,
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  }
end

M.setup_rubylsp = function()
  local lspconfig = require "lspconfig"
  local util = require "lspconfig.util"

  lspconfig.ruby_lsp.setup {
    cmd = { vim.fn.expand "~/.rbenv/shims/ruby-lsp" },
    filetypes = { "ruby" },
    root_dir = util.root_pattern("Gemfile", ".git"),
    on_attach = function(client, bufnr)
      print("ruby-lsp attached to buffer", bufnr)
    end,
    init_options = {
      enabledFeatures = {
        "codeActions",
        "diagnostics",
        "documentHighlights",
        "documentLink",
        "documentSymbols",
        "foldingRanges",
        "formatting",
        "hover",
        "inlayHints",
        "onTypeFormatting",
        "selectionRanges",
        "semanticHighlighting",
        "completion",
        "codeLens",
        "definition",
        "workspaceSymbols",
        "signatureHelp",
        "typeHierarchy",
      },
    },
  }
end

-- sql
M.setup_sqlls = function()
  local lspconfig = require "lspconfig"

  lspconfig.sqls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    cmd = { "sqls" },
    filetypes = { "sql" },
    root_dir = function()
      return vim.loop.cwd()
    end,
    settings = {
      sqls = {
        connections = {
          {
            driver = "mysql",
            -- dataSourceName = "root:root@tcp(127.0.0.1:3306)/database",
          },
        },
      },
    },
  }
end

require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettierd", "prettier" },
    markdown = { "prettier" },
    go = { "gofumpt", "goimports" },
    sh = { "shfmt" },
    sql = { "sql_formatter" },
    ruby = { "rubyfmt" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
    stop_after_first = true,
  },
}

require("conform").formatters.sql_formatter = {
  prepend_args = { "-c", vim.fn.expand "~/.config/nvim/lua/user/lsp/settings/sql_formatter.json" },
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})

return M
