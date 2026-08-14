return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
  },
  opts = {},
  event = {"CmdlineEnter"},
  ft = {"go", "gomod"},
}
