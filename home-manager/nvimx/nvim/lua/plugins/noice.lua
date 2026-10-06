return {
  "folke/noice.nvim",
  dependencies = {
    "muniftanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      -- signature help は blink.cmp に任せる (二重表示を防ぐ)
      signature = {
        enabled = false,
      },
    },
    presets = {
      -- noice が上書きする LSP hover / signature help に枠線をつける
      lsp_doc_border = true,
    },
  },
}
