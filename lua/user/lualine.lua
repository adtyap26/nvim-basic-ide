local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
}

local location = {
  "location",
  padding = 0,
}

local operatingsystem = {
  "fileformat",
  icons_enabled = false,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_get_option_value("shiftwidth", {})
end

local servername = {
  -- Lsp server name .
  function()
    local msg = "No Active Lsp"
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return msg
    end

    for _, client in ipairs(clients) do
      local attached_buffers = vim.lsp.get_buffers_by_client_id(client.id)
      local current_buf = vim.api.nvim_get_current_buf()

      if vim.tbl_contains(attached_buffers, current_buf) then
        return client.name
      end
    end
    return msg
  end,
  icon = " LSP:",
}

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { diagnostics },
    lualine_x = { servername, diff, spaces, operatingsystem, "encoding", filetype },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
}
