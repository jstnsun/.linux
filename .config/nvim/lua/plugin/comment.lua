-- comment.lua
--
-- Configuration file for a comment plugin via lazy for Neovim.
-- See https://github.com/numToStr/Comment.nvim for more information.
--
-- jstnsun

return {
    "numToStr/Comment.nvim",
    event = { "BufNewFile", "BufReadPost", "InsertEnter" },
    opts = {
        ignore = "^$",
    },
}
