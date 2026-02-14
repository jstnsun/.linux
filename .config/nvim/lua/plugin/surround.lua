-- surround.lua
--
-- Configuration file for a surround plugin via lazy for Neovim.
-- See https://github.com/kylechui/nvim-surround for more information.
--
-- jstnsun

return {
    "kylechui/nvim-surround",
    event = { "BufNewFile", "BufReadPost" },
    opts = {},
}
