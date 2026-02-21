-- mason.lua
--
-- Configuration file for the Mason plugin via lazy for Neovim.
-- See https://github.com/mason-org/mason.nvim for more information.
--
-- jstnsun

-- Manually prepend Mason's bin directory to `$PATH`.
-- This is necessary because of the lazy loading being done.
local masonbintable = { vim.fn.stdpath("data"), "mason", "bin" }
local masonbinpath = vim.fs.normalize(table.concat(masonbintable, "/"))
vim.env.PATH = masonbinpath .. ":" .. vim.env.PATH

return {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonLog", "MasonUpdate" },
    keys = {
        {
            "<leader>hm",
            "<cmd>vertical help mason.nvim<cr>",
            desc = "open [h]elp [m]ason",
        },
        {
            "<leader>mm",
            "<cmd>Mason<cr>",
            desc = "open [m]ason [m]enu",
        },
    },
    opts = {
        PATH = "skip",
        ui = {
            check_outdated_packages_on_open = false,
            width = 1,
            height = 1,
            icons = {
                package_installed = "",
                package_pending = "",
                package_uninstalled = "",
            },
        },
    },
}
