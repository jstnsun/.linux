-- lazy.lua
--
-- Configuration file that loads the lazy plugin manager for Neovim.
-- See https://lazy.folke.io/ for more information.
--
-- jstnsun

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = { import = "plugin" },
    local_spec = false,
    rocks = { enabled = false },
    install = { colorscheme = {} },
    ui = { size = { width = 1, height = 1 } },
    change_detection = { enabled = false },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "rplugin",
                "spellfile",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    readme = { enabled = false },
})
