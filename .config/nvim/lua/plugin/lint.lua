-- lint.lua
--
-- Configuration file for a linter plugin via lazy for Neovim.
-- See https://github.com/mfussenegger/nvim-lint for more information.
--
-- jstnsun

-- Use the below table to match linters with filetypes.
local linters_by_ft = {
    ["lua"] = { "selene" },
}

-- Use the below table to match markers with linters.
local markers_by_linter = {
    ["selene"] = { "selene.toml" },
}

-- Gets a table of markers based on the specified linters and above tables.
local function get_markers(linters)
    local markers = { ".git" }
    for _, linter in ipairs(linters) do
        local ms = markers_by_linter[linter]
        if ms then vim.list_extend(markers, ms) end
    end
    return markers
end

-- Try to lint the current buffer with the above configurations.
local function nvim_lint_try_lint()
    if not vim.bo.modifiable then return end

    local linters = linters_by_ft[vim.bo.filetype]
    if not linters then return end

    local markers = get_markers(linters)
    local cwd = vim.fs.root(0, markers) or vim.uv.cwd()
    require("lint").try_lint(linters, { cwd = cwd })
end

return {
    "mfussenegger/nvim-lint",
    event = { "BufNewFile", "BufReadPre" },
    keys = {
        {
            "<leader>hl",
            "<cmd>vertical help lint.txt<cr>",
            desc = "open [h]elp [l]int",
        },
        {
            "<leader>lb",
            nvim_lint_try_lint,
            desc = "[l]int [b]uffer",
        },
    },
    config = function()
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("lint-try", { clear = true }),
            desc = "Try to lint the current buffer",
            callback = nvim_lint_try_lint,
        })
    end,
}
