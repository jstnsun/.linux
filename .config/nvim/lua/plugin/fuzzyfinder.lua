-- fuzzyfinder.lua
--
-- Configuration file for a fuzzy finder plugin via lazy for Neovim.
-- See https://github.com/ibhagwan/fzf-lua for more information.
--
-- jstnsun

return {
    "ibhagwan/fzf-lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = "FzfLua",
    event = "VeryLazy",
    keys = {
        {
            "<leader>hs",
            "<cmd>vertical help fzf-lua.txt<cr>",
            desc = "open [h]elp [s]earch",
        },
        {
            "<leader>sm",
            "<cmd>FzfLua<cr>",
            desc = "open [s]earch [m]enu",
        },
    },
    opts = {
        winopts = {
            row = 0.5,
            border = "single",
            fullscreen = true,
            preview = {
                border = "single",
                wrap = true,
                scrollbar = "border",
            },
        },
        keymap = {
            builtin = {
                false,
                ["<esc>"] = "hide",
                ["<f1>"] = "toggle-help",
                ["<f2>"] = "toggle-fullscreen",
                ["<f3>"] = "toggle-preview-wrap",
                ["<f4>"] = "toggle-preview",
                ["<f5>"] = "toggle-preview-cw",
                ["<c-a-n>"] = "preview-down",
                ["<c-a-p>"] = "preview-up",
                ["<s-left>"] = "preview-reset",
                ["<s-down>"] = "preview-page-down",
                ["<s-up>"] = "preview-page-up",
            },
        },
    },
    config = function(_, opts)
        local fzf = require("fzf-lua")
        local function keymap(m, l, r, d) vim.keymap.set(m, l, r, { desc = d }) end
        fzf.setup(opts)

        keymap("n", "<leader>sb", fzf.buffers, "[s]earch [b]uffers")
        keymap("n", "<leader>sfc", fzf.files, "[s]earch [f]iles [c]wd")
        keymap("n", "<leader>sfh", function() fzf.files({ cwd = "~" }) end, "[s]earch [f]iles [h]ome")
        keymap("n", "<leader>sfy", fzf.history, "[s]earch [f]iles histor[y]")
        keymap("n", "<leader>sq", fzf.quickfix, "[s]earch [q]uickfix list")
        keymap("n", "<leader>sl", fzf.loclist, "[s]earch [l]ocation list")
        keymap("n", "<leader>si", fzf.lines, "[s]earch l[i]nes all")
        keymap("n", "<leader>sI", fzf.blines, "[s]earch l[I]nes buffer")
        keymap("n", "<leader>st", fzf.tabs, "[s]earch [t]abs")

        keymap("n", "<leader>ssw", fzf.grep_cword, "[s]earch [s]earch [w]ord")
        keymap("n", "<leader>ssW", fzf.grep_cWORD, "[s]earch [s]earch [W]ORD")
        keymap("n", "<leader>ssv", fzf.grep_visual, "[s]earch [s]earch [v]isual selection")
        keymap("n", "<leader>ssc", fzf.lgrep_curbuf, "[s]earch [s]earch [c]urrent buffer")
        keymap("n", "<leader>ssq", fzf.lgrep_quickfix, "[s]earch [s]earch [q]uickfix list")
        keymap("n", "<leader>ssl", fzf.lgrep_loclist, "[s]earch [s]earch [l]ocation list")
        keymap("n", "<leader>ssr", fzf.live_grep_resume, "[s]earch [s]earch [r]esume")
        keymap("n", "<leader>sss", fzf.live_grep_native, "[s]earch [s]earch [s]earch")

        keymap("n", "<leader>sgf", fzf.git_files, "[s]earch [g]it [f]iles")
        keymap("n", "<leader>sgs", fzf.git_status, "[s]earch [g]it [s]tatus")
        keymap("n", "<leader>sgd", fzf.git_diff, "[s]earch [g]it [d]iff")
        keymap("n", "<leader>sgh", fzf.git_hunks, "[s]earch [g]it [h]unks")
        keymap("n", "<leader>sgc", fzf.git_commits, "[s]earch [g]it workspace [c]ommits")
        keymap("n", "<leader>sgC", fzf.git_bcommits, "[s]earch [g]it document [C]ommits")
        keymap("n", "<leader>sgb", fzf.git_blame, "[s]earch [g]it [b]lame")
        keymap("n", "<leader>sgr", fzf.git_branches, "[s]earch [g]it b[r]anches")
        keymap("n", "<leader>sgw", fzf.git_worktrees, "[s]earch [g]it [w]orktrees")
        keymap("n", "<leader>sgS", fzf.git_stash, "[s]earch [g]it [S]tash")

        keymap("n", "<leader>spr", fzf.lsp_references, "[s]earch ls[p] [r]eferences")
        keymap("n", "<leader>spd", fzf.lsp_definitions, "[s]earch ls[p] [d]efinitions")
        keymap("n", "<leader>spD", fzf.lsp_declarations, "[s]earch ls[p] [D]eclarations")
        keymap("n", "<leader>spt", fzf.lsp_typedefs, "[s]earch ls[p] [t]ypedefs")
        keymap("n", "<leader>spi", fzf.lsp_implementations, "[s]earch ls[p] [i]mplementations")
        keymap("n", "<leader>spO", fzf.lsp_document_symbols, "[s]earch ls[p] document symb[O]ls")
        keymap("n", "<leader>spo", fzf.lsp_live_workspace_symbols, "[s]earch ls[p] workspace symb[o]ls")
        keymap("n", "<leader>sp[", fzf.lsp_incoming_calls, "[s]earch ls[p] [incoming")
        keymap("n", "<leader>sp]", fzf.lsp_outgoing_calls, "[s]earch ls[p] ]outgoing")
        keymap("n", "<leader>sps", fzf.lsp_type_sub, "[s]earch ls[p] [s]ub types")
        keymap("n", "<leader>spS", fzf.lsp_type_super, "[s]earch ls[p] [S]uper types")
        keymap("n", "<leader>spa", fzf.lsp_code_actions, "[s]earch ls[p] [a]ctions")
        keymap("n", "<leader>spe", fzf.lsp_finder, "[s]earch ls[p] find[e]r")
        keymap("n", "<leader>sD", fzf.diagnostics_document, "[s]earch document [D]iagnostics")
        keymap("n", "<leader>sd", fzf.diagnostics_workspace, "[s]earch workspace [d]iagnostics")

        keymap("n", "<leader>sr", fzf.resume, "[s]earch [r]esume")
        keymap("n", "<leader>sG", fzf.global, "[s]earch [G]lobal")
        keymap("n", "<leader>sh", fzf.helptags, "[s]earch [h]elp")
        keymap("n", "<leader>sM", fzf.manpages, "[s]earch [M]anpages")
        keymap("n", "<leader>snc", fzf.commands, "[s]earch [n]vim [c]mds")
        keymap("n", "<leader>s:", fzf.command_history, "[s]earch [:]cmd history")
        keymap("n", "<leader>s/", fzf.search_history, "[s]earch [/]search history")
        keymap("n", "<leader>s'", fzf.marks, "[s]earch [']marks")
        keymap("n", "<leader>sj", fzf.jumps, "[s]earch [j]ump list")
        keymap("n", '<leader>s"', fzf.registers, '[s]earch ["]registers')
        keymap("n", "<leader>sa", fzf.autocmds, "[s]earch [a]utocmds")
        keymap("n", "<leader>sno", fzf.nvim_options, "[s]earch [n]vim [o]ptions")
        keymap("n", "<leader>sk", fzf.keymaps, "[s]earch [k]eymaps")
        keymap("n", "<leader>sL", fzf.spell_suggest, "[s]earch spe[L]ling")
        keymap("n", "<leader>su", fzf.undotree, "[s]earch [u]ndotree")

        keymap("n", "<leader>scp", fzf.complete_path, "[s]earch [c]omplete [p]ath")
        keymap("n", "<leader>scf", fzf.complete_file, "[s]earch [c]omplete [f]ile")
    end,
}
