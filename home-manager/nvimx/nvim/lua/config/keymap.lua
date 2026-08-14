local keyset = vim.keymap.set

keyset("i", "jj", "<ESC>")

keyset("n", "<TAB>", "<CMD>bnext<CR>")
keyset("n", "<S-TAB>", "<CMD>bprev<CR>")

local lsp = vim.lsp.buf
local diag = vim.diagnostic
keyset("n", "gd", lsp.definition)
keyset("n", "K", lsp.hover)
keyset("n", "gr", lsp.rename)
keyset("n", "ga", lsp.code_action)
keyset("n", "ge", diag.open_float)
