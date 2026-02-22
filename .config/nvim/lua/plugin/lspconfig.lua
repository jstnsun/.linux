-- lspconfig.lua
--
-- Configuration file for the lspconfig plugin via lazy for Neovim.
-- See https://github.com/neovim/nvim-lspconfig for more information.
--
-- jstnsun

return {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufNewFile", "BufReadPre" },
    keys = {
        {
            "<leader>hp",
            "<cmd>vertical help lspconfig.txt<cr>",
            desc = "open [h]elp ls[p]",
        },
        {
            "<leader>pm",
            "<cmd>LspInfo<cr>",
            desc = "open ls[p] [m]enu",
        },
        {
            "<leader>pr",
            "<cmd>LspRestart<cr>",
            desc = "ls[p] [r]estart",
        },
    },
    config = function()
        vim.lsp.enable({
            "lua_ls",
        })
    end,
}
