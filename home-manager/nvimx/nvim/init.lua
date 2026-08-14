vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.opt.scrolloff = 3

require("config.lazy")
require("config.lsp")
require("config.keymap")
vim.cmd.colorscheme "catppuccin-nvim"
