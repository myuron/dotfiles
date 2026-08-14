-- nvim-lspconfig の lsp/jsonls.lua とマージされる（rtp 上の同名ファイルは
-- すべて vim.lsp.config で deep merge される）ので、ここでは追加分だけ書く。
-- スキーマ本体の取得はサーバー (request-light) 側が HTTP で行う。
-- json.schemastore.org は www.schemastore.org へ 301 するため正規 URL を直接指定する。
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
