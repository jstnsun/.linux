-- gitsigns.lua
--
-- Configuration file for the gitsigns plugin via lazy for Neovim.
-- See https://github.com/lewis6991/gitsigns.nvim for more information.
--
-- jstnsun

-- Use the below characters for both staged and unstaged signs.
local signs_tbl = {
    delete = { text = "" },
    topdelete = { text = "▲" },
    changedelete = { text = "┇" },
}

-- On-attach function used to configure gitsigns keymaps.
local function gitsigns_on_attach(bufnr)
    local gs = package.loaded.gitsigns
    local function keymap(m, l, r, d) vim.keymap.set(m, l, r, { buffer = bufnr, desc = d }) end

    keymap("n", "[c", function()
        if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
        else
            gs.nav_hunk("prev")
        end
    end, "jump to previous [c]hange")
    keymap("n", "]c", function()
        if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
        else
            gs.nav_hunk("next")
        end
    end, "jump to next [c]hange")
    keymap("n", "[C", function() gs.nav_hunk("last") end, "jump to last [C]hange")
    keymap("n", "]C", function() gs.nav_hunk("first") end, "jump to first [C]hange")
    keymap("n", "<leader>ge", gs.stage_hunk, "(un)stag[e] hunk")
    keymap("n", "<leader>gr", gs.reset_hunk, "[r]eset hunk")
    keymap("n", "<leader>gE", gs.stage_buffer, "stag[E] buffer")
    keymap("n", "<leader>gR", gs.reset_buffer, "[R]eset buffer")
    keymap("n", "<leader>gp", gs.preview_hunk, "preview hunk [p]oppup")
    keymap("n", "<leader>gi", gs.preview_hunk_inline, "preview hunk [i]nline")
    keymap("n", "<leader>gb", gs.blame, "blame [b]uffer")
    keymap("n", "<leader>gn", gs.blame_line, "blame li[n]e")
    keymap("n", "<leader>gd", gs.diffthis, "[d]iff against index")
    keymap("n", "<leader>gD", function() gs.diffthis("~") end, "[D]iff against ~")
    keymap("n", "<leader>gq", gs.setqflist, "view hunks in [q]uickfix list")
    keymap("n", "<leader>gw", gs.setloclist, "vie[w] hunks in location list")
    keymap("n", "<leader>gt", gs.toggle_word_diff, "[t]oggle show word diff")
    keymap("n", "<leader>gT", gs.toggle_current_line_blame, "[T]oggle show blame line")
end

return {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    event = { "BufNewFile", "BufReadPost" },
    keys = {
        {
            "<leader>hg",
            "<cmd>vertical help gitsigns.nvim<cr>",
            desc = "open [h]elp [g]itsigns",
        },
        {
            "<leader>gm",
            "<cmd>Gitsigns<cr>",
            desc = "open [g]itsigns [m]enu",
        },
    },
    opts = {
        signs = signs_tbl,
        signs_staged = signs_tbl,
        current_line_blame_opts = {
            virt_text_pos = "right_align",
            delay = 500,
            ignore_whitespace = true,
        },
        current_line_blame_formatter = "<author>, <author_time:%R>",
        on_attach = gitsigns_on_attach,
    },
}
