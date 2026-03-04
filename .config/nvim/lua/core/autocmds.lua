-- autocmds.lua
--
-- Configuration file that declares autocommands for Neovim.
-- See https://neovim.io/doc/user/lua-guide.html#_autocommands for more information.
--
-- jstnsun

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("q-to-quit", { clear = true }),
    desc = "keymap 'q' to quit specific windows",
    pattern = { "checkhealth", "help", "lspinfo", "man" },
    callback = function() vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true }) end,
})
