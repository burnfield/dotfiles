vim.g.mapleader = " "
vim.g.maplocalleader = " "

local vim = vim
local Plug = vim.fn["plug#"]

vim.call("plug#begin")
Plug("nvim-treesitter/nvim-treesitter")
Plug("catppuccin/nvim")
Plug("ibhagwan/fzf-lua")
Plug("folke/which-key.nvim")
Plug("nvim-tree/nvim-web-devicons")
Plug("nvim-lualine/lualine.nvim")
Plug("echasnovski/mini.surround")
Plug("echasnovski/mini.bufremove")
Plug("williamboman/mason.nvim")
Plug("stevearc/conform.nvim")
Plug("folke/lazydev.nvim")

Plug("tpope/vim-fugitive")
Plug("lewis6991/gitsigns.nvim")

Plug("saghen/blink.cmp", { ["tag"] = "*" })
Plug("L3MON4D3/LuaSnip")

Plug("mfussenegger/nvim-lint")
vim.call("plug#end")

-- BUILTINS
vim.o.scrolloff = 3
vim.o.sidescrolloff = 2
vim.o.linebreak = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.cmdheight = 0
vim.cmd([[set clipboard+=unnamedplus]])

-- Spaces and tabs
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.smartindent = true
vim.o.expandtab = true

-- Ui
vim.o.termguicolors = true
vim.o.splitright = true
vim.o.list = true

-- Searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- Folding
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99

vim.cmd([[set directory^=$HOME/.vim/tmp//]])

vim.o.grepprg = "rg --vimgrep --no-heading"
vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"

-- Avoid showing message extra message when using completion
vim.cmd([[set shortmess+=c]])
vim.cmd([[set complete-=i]])
vim.o.completeopt = menu, menuone, noinsert, noselect

-- LSP
vim.lsp.enable("basedpyright")
vim.lsp.enable("lua_ls")

-- NON-BUILTINS
vim.cmd([[colorscheme catppuccin-latte]])
require("nvim-treesitter.configs").setup({
    ensure_installed = { "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "starlark" },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
})

-- LUA-LINES
local breadcrumbs = function()
    local ts_utils = require("nvim-treesitter.ts_utils")
    return require("nvim-treesitter").statusline({
        indicator_size = 60,
        type_patterns = { "class", "function", "method" },
        transform_fn = function(_line, node)
            return vim.treesitter.get_node_text(ts_utils.get_named_children(node)[1], 0)
        end,
        separator = "->",
        allow_duplicates = false,
    })
end

local winbar = {
    lualine_a = { { "filename", file_status = false, shorting_target = 20 } },
    lualine_b = { { breadcrumbs } },
    lualine_z = {
        { "filetype", icon_only = true, separator = "", padding = 0 },
        {
            "lsp_status",
            icon = "",
            ignore_lsp = { "ruff" },
            separator = "",
            draw_empty = " ",
            padding = { right = 1 },
        },
    },
}

require("lualine").setup({
    options = {
        globalstatus = true,
    },
    sections = {
        lualine_c = { { "filename", path = 3 } },
    },
    winbar = winbar,
    inactive_winbar = winbar,
})

vim.keymap.set({ "n", "x" }, "s", "<Nop>")
require("fzf-lua").setup({ { "hide" } })
require("gitsigns").setup()
require("mini.surround").setup()
require("mini.bufremove").setup({ silent = true })
require("mason").setup()
require("blink.cmp").setup({
    snippets = { preset = "luasnip" },
})
require("lazydev").setup()

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
    },
})
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.bo[args.buf].formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
})

require("lint").linters_by_ft = {
    python = { "mypy" },
    bash = { "shellcheck" },
    sh = { "shellcheck" },
}

vim.diagnostic.config({ float = { source = true } })
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

-- Keymaps
-- BUILTINS
vim.keymap.set({ "n" }, "<c-j>", "<cmd>cnext<cr>", { desc = "Next qlist", silent = true })
vim.keymap.set({ "n" }, "<c-k>", "<cmd>cprev<cr>", { desc = "Previous qlist", silent = true })
vim.keymap.set({ "n" }, "<c-h>", "<cmd>cfirst<cr>", { desc = "First qlist", silent = true })
vim.keymap.set({ "n" }, "<c-l>", "<cmd>clast<cr>", { desc = "Last qlist", silent = true })
local wk = require("which-key")
wk.add({
    {
        { "<leader>c", group = "vimrc" },
        { "<leader>cp", group = "Plug" },
        { "<leader>ce", "<cmd>e ~/.config/nvim/init.lua<cr>", desc = "Edit" },
        { "<leader>cs", "<cmd>source ~/.config/nvim/init.lua<cr>", desc = "Source" },
        { "<leader>cpi", "<cmd>PlugInstall<cr>", desc = "Install" },
        { "<leader>cpc", "<cmd>PlugClean<cr>", desc = "Clean" },
    },
    { "g", group = "goto" },
})
-- FZF-LUA
vim.keymap.set({ "n", "v" }, "<leader><leader>", "<cmd>FzfLua resume<cr>", { desc = "Grep current WORD" })
vim.keymap.set({ "n", "v" }, "<leader>f", "<cmd>FzfLua git_files<cr>", { desc = "GitFiles" })
vim.keymap.set({ "n", "v" }, "<leader>F", "<cmd>FzfLua files<cr>", { desc = "Files" })
vim.keymap.set({ "n", "v" }, "<leader>b", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
vim.keymap.set({ "n", "v" }, "grr", "<cmd>FzfLua lsp_references<cr>", { desc = "refrences" })
vim.keymap.set({ "n", "v" }, "gO", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "refrences" })
vim.keymap.set({ "n", "v" }, "grR", "<cmd>FzfLua grep_cWORD<cr>", { desc = "Grep current WORD" })
vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>", function()
    require("fzf-lua").complete_path()
end, { silent = true, desc = "Fuzzy complete path" })

wk.add({
    { "s", group = "surround" },
})

local toggle_hint = function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
wk.add({
    { "t", group = "toggle" },
    { "th", toggle_hint, desc = "inlay hint" },
})

wk.add({
    { "<c-w>b", "<cmd>lua require('mini.bufremove').delete()<cr>", desc = "Delete buffer" },
})

wk.add({
    { "<leader>m", group = "Mason" },
    { "<leader>mm", "<cmd>Mason<cr>", desc = "Mason" },
    { "<leader>mi", "<cmd>Mason<cr>", desc = "Install" },
    { "<leader>mu", "<cmd>Mason<cr>", desc = "Update" },
})

-- GIT
wk.add({
    { "<leader>g", group = "Git" },
    { "<leader>gh", group = "Hunk" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
    { "<leader>gd", "<cmd>Git difftool<cr>", desc = "Diffs" },
    { "<leader>gm", "<cmd>Git mergetool<cr>", desc = "Merge" },
    { "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset", mode = { "n", "v" } },
    { "<leader>gha", "<cmd>Gitsigns stage_hunk<cr>", desc = "Add", mode = { "n", "v" } },
    { "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Unstage", mode = { "n", "v" } },
})
