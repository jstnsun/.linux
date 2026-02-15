-- lualine.lua
--
-- Configuration file for the lualine plugin via lazy for Neovim.
-- See https://github.com/nvim-lualine/lualine.nvim for more information.
--
-- jstnsun

-- Use gitsigns instead of lualine to track git diff information.
local function diff_source()
    local gs_status_dict = vim.b.gitsigns_status_dict
    if gs_status_dict then
        return {
            added = gs_status_dict.added,
            modified = gs_status_dict.changed,
            removed = gs_status_dict.removed,
        }
    end
end

-- Use the below autocommands and function to display macro recording.
local recording = ""
vim.api.nvim_create_autocmd("RecordingEnter", {
    group = vim.api.nvim_create_augroup("lualine-recording-enter", { clear = true }),
    desc = "Sets the recording macro string and refreshes lualine",
    callback = function()
        recording = "Recording @" .. vim.fn.reg_recording()
        require("lualine").refresh()
    end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
    group = vim.api.nvim_create_augroup("lualine-recording-leave", { clear = true }),
    desc = "Unsets the recording macro string and refreshes lualine",
    callback = function()
        recording = ""
        require("lualine").refresh()
    end,
})
local function display_recording() return recording end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    opts = {
        options = {
            component_separators = { left = "", right = "│" },
            always_show_tabline = false,
            globalstatus = vim.o.laststatus == 3,
        },
        sections = {
            lualine_a = {
                "mode",
            },
            lualine_b = {
                { "filetype", icon_only = true, padding = { left = 1, right = 0 } },
                { "filename", newfile_status = true, padding = { left = 0, right = 1 } },
            },
            lualine_c = {
                { "lsp_status", padding = { left = 1, right = 0 } },
                { "diagnostics", update_in_insert = true },
            },
            lualine_x = {
                { display_recording },
                "searchcount",
            },
            lualine_y = {
                { "diff", source = diff_source },
                "branch",
            },
            lualine_z = {
                { "progress", separator = "" },
                { "location", padding = { left = 0, right = 1 } },
            },
        },
        tabline = {
            lualine_a = {
                { "tabs", mode = 1, path = 3, show_modified_status = false },
            },
            lualine_x = {
                { "diagnostics", update_in_insert = true },
            },
            lualine_y = {
                { "diff", source = diff_source },
            },
        },
        extensions = { "fzf", "nvim-tree" },
    },
}
