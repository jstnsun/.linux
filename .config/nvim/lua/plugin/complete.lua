-- complete.lua
--
-- Configuration file for a completion plugin via lazy for Neovim.
-- See https://github.com/saghen/blink.cmp for more information.
--
-- jstnsun

-- Toggle whether blink auto-shows completion menus.
local function blink_toggle_auto_show()
    local config = require("blink.cmp.config")

    config.completion.menu.auto_show = not config.completion.menu.auto_show
end

return {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = "rafamadriz/friendly-snippets",
    event = { "CmdlineEnter", "InsertEnter" },
    keys = {
        {
            "<leader>hc",
            "<cmd>vertical help blink-cmp.txt<cr>",
            desc = "open [h]elp [c]omplete",
        },
        {
            "<leader>cm",
            blink_toggle_auto_show,
            desc = "toggle [c]omplete [m]enu",
        },
    },
    opts = {
        keymap = {
            ["<c-1>"] = { function(cmp) cmp.accept({ index = 1 }) end },
            ["<c-2>"] = { function(cmp) cmp.accept({ index = 2 }) end },
            ["<c-3>"] = { function(cmp) cmp.accept({ index = 3 }) end },
            ["<c-4>"] = { function(cmp) cmp.accept({ index = 4 }) end },
            ["<c-5>"] = { function(cmp) cmp.accept({ index = 5 }) end },
            ["<c-6>"] = { function(cmp) cmp.accept({ index = 6 }) end },
            ["<c-7>"] = { function(cmp) cmp.accept({ index = 7 }) end },
            ["<c-8>"] = { function(cmp) cmp.accept({ index = 8 }) end },
            ["<c-9>"] = { function(cmp) cmp.accept({ index = 9 }) end },
            ["<c-0>"] = { function(cmp) cmp.accept({ index = 10 }) end },
        },
        completion = {
            keyword = { range = "full" },
            trigger = {
                show_on_backspace = true,
                show_on_backspace_in_keyword = true,
            },
            menu = {
                max_height = 12,
                draw = { treesitter = { "lsp" } },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
            ghost_text = {
                enabled = true,
                show_with_menu = false,
            },
        },
        signature = {
            enabled = true,
            trigger = { show_on_insert = true },
            window = { max_height = 20 },
        },
        fuzzy = {
            implementation = "lua",
            max_typos = 0,
            sorts = {
                "exact",
                "score",
                "sort_text",
            },
            prebuilt_binaries = { download = false },
        },
        appearance = { nerd_font_variant = "normal" },
        cmdline = {
            keymap = {
                preset = "inherit",
                ["<tab>"] = { "show_and_insert_or_accept_single", "select_next" },
                ["<s-tab>"] = { "show_and_insert_or_accept_single", "select_prev" },
            },
            completion = {
                menu = { auto_show = function(_) return vim.fn.getcmdtype() == ":" end },
            },
        },
    },
}
