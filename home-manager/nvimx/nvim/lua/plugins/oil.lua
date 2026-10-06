return {
  "stevearc/oil.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  lazy = false,
  keys = {
    { "<leader>E", function() vim.cmd.Oil() end, desc = "File Explorer (oil)" },
  },
}
