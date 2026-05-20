-- lspconfig.lua
--
-- Configuration file for the lspconfig plugin via lazy for Neovim.
-- See https://github.com/neovim/nvim-lspconfig for more information.
--
-- jstnsun

return {
    "neovim/nvim-lspconfig",
    event = { "BufNewFile", "BufReadPre" },
    keys = {
        {
            "<leader>hp",
            "<cmd>vertical help lspconfig.txt<cr>",
            desc = "open [h]elp ls[p]",
        },
        {
            "<leader>pm",
            "<cmd>checkhealth vim.lsp<cr>",
            desc = "open ls[p] [m]enu",
        },
        {
            "<leader>pr",
            "<cmd>lsp restart<cr>",
            desc = "ls[p] [r]estart",
        },
    },
    config = function()
        vim.lsp.enable({
            "basedpyright",
            "lua_ls",
        })
    end,
}
