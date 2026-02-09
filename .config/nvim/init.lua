-- init.lua
--
-- Main configuration file for the Neovim text editor.
-- See https://neovim.io/doc/user/ for more information.
--
-- jstnsun

-- Load `core` submodules in this order so they are all applied properly.
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lazy")
require("core.after")
