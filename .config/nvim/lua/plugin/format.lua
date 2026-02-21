-- format.lua
--
-- Configuration file for a formatter plugin via lazy for Neovim.
-- See https://github.com/stevearc/conform.nvim for more information.
--
-- jstnsun

return {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    event = { "BufNewFile", "BufReadPost" },
    keys = {
        {
            "<leader>hf",
            "<cmd>vertical help conform.txt<cr>",
            desc = "open [h]elp [f]ormat",
        },
        {
            "<leader>fm",
            "<cmd>ConformInfo<cr>",
            desc = "open [f]ormat [m]enu",
        },
        {
            "<leader>fb",
            function() require("conform").format({ async = true }) end,
            desc = "[f]ormat [b]uffer asynchronously",
        },
        {
            "<leader>fs",
            function() require("conform").format({ async = true, formatters = { "codespell" } }) end,
            desc = "[f]ormat [s]pelling in buffer",
        },
    },
    opts = {
        notify_on_error = true,
        formatters_by_ft = {
            lua = { "stylua" },
            ["_"] = { "trim_whitespace" },
        },
        default_format_opts = {
            timeout_ms = 2000,
            lsp_format = "fallback",
        },
        format_on_save = {},
    },
}
