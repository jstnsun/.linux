-- whichkey.lua
--
-- Configuration file for the WhichKey plugin via lazy for Neovim.
-- See https://github.com/folke/which-key.nvim for more information.
--
-- jstnsun

return {
    "folke/which-key.nvim",
    cmd = "WhichKey",
    event = "VeryLazy",
    keys = {
        {
            "<leader>h?",
            "<cmd>vertical help which-key.nvim.txt<cr>",
            desc = "open [h]elp whichkey[?]",
        },
        {
            "<leader>?",
            "<cmd>WhichKey<cr>",
            desc = "whichkey[?]",
        },
    },
    opts = {
        preset = "modern",
        delay = 400,
        spec = {
            { "<leader>f", group = "format" },
            { "<leader>g", group = "gitsigns" },
            { "<leader>h", group = "help" },
            { "<leader>l", group = "lint" },
            { "<leader>m", group = "mason" },
            { "<leader>p", group = "lsp" },
            { "<leader>s", group = "search" },
        },
        win = { border = "single" },
        keys = {
            scroll_down = "<c-n>",
            scroll_up = "<c-p>",
        },
        icons = { mappings = false },
        show_help = false,
    },
}
