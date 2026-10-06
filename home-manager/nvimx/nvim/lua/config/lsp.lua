-- hover / signature help / diagnostic float など全フローティングウィンドウに枠線をつける。
vim.o.winborder = "rounded"

--- `@vue/typescript-plugin` の場所を実行時に解決する。
--- nix の vue-language-server パッケージに同梱されているものを使う
--- (プロジェクトの node_modules には入っていない)。
--- store パスはバージョン更新で変わるのでハードコードしない。
local function vue_plugin_location()
  local exe = vim.fn.exepath("vue-language-server")
  if exe == "" then
    return nil
  end
  local store_root = vim.fs.dirname(vim.fs.dirname(vim.uv.fs_realpath(exe) or exe))
  local location = vim.fs.joinpath(store_root, "lib/language-tools/packages/language-server")
  if vim.uv.fs_stat(vim.fs.joinpath(location, "node_modules/@vue/typescript-plugin")) then
    return location
  end
  return nil
end

-- Vue Language Server は v3 以降 hybrid mode 専用で、SFC の CSS/HTML しか見ない。
-- <script setup> の TypeScript は ts_ls 側に読み込ませた @vue/typescript-plugin が担当し、
-- vue_ls は tsserver/request を同じバッファの ts_ls へ転送する。
-- そのため ts_ls を vue にも attach させる必要がある。
--
-- この設定を lsp/ts_ls.lua に置くと、rtp 上で後に来る nvim-lspconfig の
-- lsp/ts_ls.lua に filetypes を上書きされてしまう。
-- vim.lsp.config() 経由の設定は rtp の lsp/*.lua より優先されるのでここで指定する。
local vue_plugin = vue_plugin_location()

vim.lsp.config("ts_ls", {
  -- filetypes は deep merge ではなく置き換えなので、既定の 4 つを再掲する。
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "cssls"
  },
  init_options = {
    hostInfo = "neovim",
    plugins = vue_plugin and {
      {
        name = "@vue/typescript-plugin",
        location = vue_plugin,
        languages = { "vue" },
      },
    } or nil,
  },
})

vim.lsp.enable({
  "lua_ls",
  "nixd",
  "jsonls",
  "bashls",
  "gopls",
  "rust_analyzer",
  "vue_ls",
  "ts_ls"
})
