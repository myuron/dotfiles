---@type vim.lsp.Config
return {
  settings = {
    json = {
      validate = { enable = true },
      schemas = {
        {
          url = "https://www.schemastore.org/claude-code-settings.json",
          fileMatch = { "**/.claude/settings.json", "**/.claude/settings.local.json" },
        },
        {
          url = "https://www.schemastore.org/claude-code-keybindings.json",
          fileMatch = { "**/.claude/keybindings.json" },
        },
      },
    },
  },
}
