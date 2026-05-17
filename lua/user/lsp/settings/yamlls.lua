return {
  settings = {
    yaml = {
      schemas = {
        kubernetes            = { "*.yaml", "*.yml" },
        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yaml,yml}",
        ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.{yaml,yml}",
      },
      schemaStore = {
        enable = false,
      },
      validate  = true,
      completion = true,
      hover     = true,
    },
  },
}
