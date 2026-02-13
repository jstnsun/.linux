-- colorscheme.lua
--
-- Configuration file for a colorscheme plugin via lazy for Neovim.
-- See https://github.com/folke/tokyonight.nvim for more information.
--
-- jstnsun

return {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
        style = "storm",
        transparent = true,
        styles = {
            keywords = { italic = false },
            sidebars = "transparent",
            floats = "transparent",
        },
        dim_inactive = true,
        lualine_bold = true,
    },
}
