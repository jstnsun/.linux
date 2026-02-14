-- ibl.lua
--
-- Configuration file for the indent-blankline plugin via lazy for Neovim.
-- See https://github.com/lukas-reineke/indent-blankline.nvim for more information.
--
-- jstnsun

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    cmd = { "IBLToggle", "IBLToggleScope" },
    event = { "BufNewFile", "BufReadPost" },
    opts = {
        indent = { char = "│", tab_char = "╎" },
        scope = { show_start = false, show_end = false },
    },
}
