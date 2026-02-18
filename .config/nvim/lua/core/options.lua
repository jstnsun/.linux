-- options.lua
--
-- Configuration file that sets options and variables for Neovim.
-- See https://neovim.io/doc/user/lua-guide.html#_options for more information.
--
-- jstnsun

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.o.breakindent = true
vim.o.cmdheight = 0
vim.o.confirm = true
vim.o.copyindent = true
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.expandtab = true
vim.opt.fillchars = { eob = " " }
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.laststatus = 3
vim.o.linebreak = true
vim.o.list = true
vim.opt.listchars = {
    lead = "·",
    nbsp = "␣",
    tab = "→ ",
    trail = "·",
}
vim.o.mouse = "a"
vim.o.number = true
vim.o.numberwidth = 3
vim.o.preserveindent = true
vim.o.relativenumber = true
vim.o.ruler = false
vim.o.scrolloff = 8
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.shortmess = "aoOstTICF"
vim.o.showmode = false
vim.o.sidescrolloff = 8
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.tabstop = 4
vim.o.timeoutlen = 400
vim.o.updatetime = 1000
vim.o.virtualedit = "block"
vim.o.whichwrap = "b,s,<,>,[,]"
