-- explorer.lua
--
-- Configuration file for a file explorer plugin via lazy for Neovim.
-- See https://github.com/nvim-tree/nvim-tree.lua for more information.
--
-- jstnsun

-- Autocommand that attempts to ignore explorers from blocking closing/quitting.
vim.api.nvim_create_autocmd("QuitPre", {
    group = vim.api.nvim_create_augroup("nvim-tree-quit", { clear = true }),
    desc = "Ignores nvim-tree explorers when closing/quitting",
    callback = function()
        if vim.bo.filetype == "NvimTree" then return end
        if not require("nvim-tree.api").tree.is_visible() then return end

        local win_count = 0
        for _, win_id in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(win_id).focusable then win_count = win_count + 1 end
            if win_count > 2 then return end
        end
        if #vim.api.nvim_list_tabpages() > 1 then
            vim.api.nvim_cmd({ cmd = "tabclose" }, {})
        else
            vim.api.nvim_cmd({ cmd = "qall" }, {})
        end
    end,
})

-- Close explorer if it's currently focused, otherwise (open and) focus on it.
local function nvim_tree_focus_toggle()
    local api = require("nvim-tree.api")

    if vim.bo.filetype == "NvimTree" then
        api.tree.close_in_this_tab()
    else
        api.tree.open()
    end
end

-- On-attach function used to configure explorer keymaps.
local function nvim_tree_on_attach(bufnr)
    local api = require("nvim-tree.api")
    local function keymap(m, l, r, d) vim.keymap.set(m, l, r, { buffer = bufnr, desc = d }) end

    keymap("n", "<2-LeftMouse>", api.node.open.edit, "Open")
    keymap("n", "<c-b>", api.filter.no_buffer.toggle, "Toggle Filter: No Buffer")
    keymap("n", "<c-c>", api.filter.custom.toggle, "Toggle Filter: Custom")
    keymap("n", "<c-g>", api.filter.git.clean.toggle, "Toggle Filter: Git Clean")
    keymap("n", "<c-h>", api.tree.toggle_hidden_filter, "Toggle Filter: Dotfiles")
    keymap("n", "<c-i>", api.tree.toggle_gitignore_filter, "Toggle Filter: Gitignore")
    keymap("n", "<c-l>", api.node.open.toggle_group_empty, "Toggle Group Empty")
    keymap("n", "<c-m>", api.filter.no_bookmark.toggle, "Toggle Filter: No Bookmark")
    keymap("n", "<c-r>", api.tree.reload, "Refresh")
    keymap("n", "<c-y>", api.fs.copy.absolute_path, "Copy Absolute Path")
    keymap("n", "<cr>", api.node.open.edit, "Open")
    keymap("n", "<esc>", api.filter.live.clear, "Clear")
    keymap("n", "<tab>", api.node.open.preview, "Open Preview")
    keymap("n", "a", api.fs.create, "Create")
    keymap("n", "c", api.fs.copy.node, "Copy")
    keymap("n", "d", api.fs.trash, "Trash")
    keymap("n", "D", api.fs.remove, "Delete")
    keymap("n", "e", api.fs.rename_full, "Rename: Full Path")
    keymap("n", "E", api.tree.expand_all, "Expand All")
    keymap("n", "h", api.tree.change_root_to_parent, "Move Up Directory")
    keymap("n", "i", api.node.show_info_popup, "Info")
    keymap("n", "J", api.node.navigate.sibling.last, "Last Sibling")
    keymap("n", "K", api.node.navigate.sibling.first, "First Sibling")
    keymap("n", "m", api.marks.toggle, "Bookmark")
    keymap("n", "M", api.marks.bulk.move, "Move Bookmarked")
    keymap("n", "o", api.node.open.no_window_picker, "Open No Window Picker")
    keymap("n", "p", api.node.navigate.parent, "Parent Directory")
    keymap("n", "q", api.tree.close, "Close")
    keymap("n", "Q", api.tree.close_in_all_tabs, "Close In All Tabs")
    keymap("n", "r", api.fs.rename_basename, "Rename: Basename")
    keymap("n", "R", api.fs.rename, "Rename")
    keymap("n", "s", api.filter.live.start, "Search")
    keymap("n", "t", api.node.open.tab_drop, "Open In New Tab")
    keymap("n", "v", api.fs.paste, "Paste")
    keymap("n", "W", api.tree.collapse_all, "Collapse All")
    keymap("n", "x", api.fs.cut, "Cut")
    keymap("n", "y", api.fs.copy.filename, "Copy Name")
    keymap("n", "Y", api.fs.copy.relative_path, "Copy Relative Path")
    keymap("n", ".", api.node.run.cmd, "Run Command")
    keymap("n", ",", api.node.run.system, "Run System")
    keymap("n", ";", api.node.open.horizontal, "Open In Horizontal Split")
    keymap("n", "'", api.node.open.vertical, "Open In Vertical Split")
    keymap("n", "-", function() api.tree.resize({ relative = -2 }) end, "Decrease Size")
    keymap("n", "=", function() api.tree.resize({ relative = 2 }) end, "Increase Size")
    keymap("n", "0", api.tree.resize, "Reset Size")
    keymap("n", "?", api.tree.toggle_help, "Help")
    keymap("n", "[c", api.node.navigate.git.prev, "Prev Git")
    keymap("n", "]c", api.node.navigate.git.next, "Next Git")
end

-- Comparison function replicating coreutils' ls -v --group-directories-first order.
local function coreutils_cmp(a, b)
    if a.type == "directory" and b.type ~= "directory" then
        return true
    elseif a.type ~= "directory" and b.type == "directory" then
        return false
    end

    a = a.name
    b = b.name
    for i = 1, math.max(string.len(a), string.len(b)), 1 do
        local l = string.sub(a, i)
        local r = string.sub(b, i)
        if type(tonumber(string.sub(l, 1, 1))) == "number" and type(tonumber(string.sub(r, 1, 1))) == "number" then
            local l_num = tonumber(string.match(l, "^[0-9]+"))
            local r_num = tonumber(string.match(r, "^[0-9]+"))
            if l_num ~= r_num then return l_num < r_num end
        elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
            return l < r
        end
    end
end
local function nvim_tree_sorter(nodes) table.sort(nodes, coreutils_cmp) end

-- Shorten root label to only show directory anchor characters for a condensed view.
local function nvim_tree_short_root_label(path)
    path = path:gsub(os.getenv("HOME"), "~", 1)
    return path:gsub("([a-zA-Z])[a-z0-9]+", "%1") .. (path:match("[a-zA-Z]([a-z0-9]*)$") or "")
end

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "NvimTreeFocus", "NvimTreeToggle" },
    keys = { { "<leader>e", nvim_tree_focus_toggle, desc = "open [e]xplorer" } },
    opts = {
        on_attach = nvim_tree_on_attach,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = true,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        sort = { sorter = nvim_tree_sorter },
        view = { width = 20 },
        renderer = {
            add_trailing = true,
            group_empty = true,
            root_folder_label = nvim_tree_short_root_label,
            special_files = {},
            icons = {
                glyphs = {
                    bookmark = "",
                    hidden = "󰘓",
                    folder = { arrow_closed = " ", arrow_open = " " },
                    git = {
                        unstaged = "",
                        staged = "",
                        unmerged = "",
                        renamed = "",
                        untracked = "",
                        deleted = "",
                        ignored = "",
                    },
                },
            },
        },
        update_focused_file = { enable = true },
        modified = { enable = true },
        live_filter = { prefix = "s: ", always_show_folders = false },
        actions = {
            file_popup = { open_win_config = { border = "single" } },
            open_file = { window_picker = { enable = false } },
        },
        ui = { confirm = { trash = false, default_yes = true } },
        bookmarks = { persist = true },
    },
}
