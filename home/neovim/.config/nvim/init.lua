vim.g.mapleader = " "
vim.g.maplocalleader = " "

local vim = vim

local gh = function(repo)
    return "https://github.com/" .. repo
end

vim.pack.add({
    gh("nvim-treesitter/nvim-treesitter"),
    { src = gh("catppuccin/nvim"), name = "catppuccin" },
    gh("ibhagwan/fzf-lua"),
    gh("folke/which-key.nvim"),
    gh("nvim-tree/nvim-web-devicons"),
    gh("nvim-lualine/lualine.nvim"),
    gh("echasnovski/mini.surround"),
    gh("echasnovski/mini.bufremove"),
    gh("williamboman/mason.nvim"),
    gh("stevearc/conform.nvim"),
    gh("folke/lazydev.nvim"),
    gh("vimwiki/vimwiki"),

    gh("tpope/vim-fugitive"),
    gh("tpope/vim-dispatch"),
    gh("tpope/vim-sleuth"),
    gh("lewis6991/gitsigns.nvim"),
    gh("TamaMcGlinn/vim-gerritbrowse"),

    { src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
    gh("L3MON4D3/LuaSnip"),

    gh("mfussenegger/nvim-lint"),
})

local pack_clean = function()
    local unused = vim.iter(vim.pack.get())
        :filter(function(p)
            return not p.active
        end)
        :map(function(p)
            return p.spec.name
        end)
        :totable()

    if #unused == 0 then
        vim.notify("vim.pack: nothing to clean")
        return
    end

    vim.pack.del(unused)
end

-- BUILTINS
vim.o.scrolloff = 3
vim.o.sidescrolloff = 2
vim.o.linebreak = true
vim.o.swapfile = false
vim.o.wrap = false
vim.cmd([[set clipboard+=unnamedplus]])
vim.cmd([[set number]])

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

-- vimwiki
vim.cmd([[let g:vimwiki_list = [{'path': '~/vimwiki/',
\ 'syntax': 'markdown', 'ext': 'md'}]
]])
--

-- LSP
vim.lsp.enable("basedpyright")
-- vim.lsp.enable("ty")
vim.lsp.enable("ruff")
vim.lsp.enable("clangd")
vim.lsp.enable("rust")
vim.lsp.enable("lua_ls")
vim.lsp.enable("starpls")

-- NON-BUILTINS
vim.cmd([[colorscheme catppuccin-macchiato]])
require("nvim-treesitter").install({
    "cpp",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "python",
    "starlark",
})
-- require("nvim-treesitter.configs").setup({
--     ensure_installed = { "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "starlark" },
--     sync_install = false,
--     auto_install = true,
--     highlight = { enable = true },
-- })

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
        lualine_c = { { "filename", path = 1 } },
    },
    winbar = winbar,
    inactive_winbar = winbar,
})

vim.keymap.set({ "n", "x" }, "s", "<Nop>")
require("fzf-lua").setup({
    winopts = {
        height = 0.5, -- window height
        width = 1, -- window width
        row = 1, -- window row position (0=top, 1=bottom)
        col = 1,
        backdrop = 100,
    },
    { "hide" },
})
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
    -- bash = { "shellcheck" },
    -- sh = { "shellcheck" },
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
        { "<leader>cp", group = "Pack" },
        { "<leader>ce", "<cmd>tabnew ~/.config/nvim/init.lua<cr>", desc = "Edit" },
        { "<leader>cs", "<cmd>source ~/.config/nvim/init.lua<cr>", desc = "Source" },
        { "<leader>cpu", vim.pack.update, desc = "Update" },
        { "<leader>cpc", pack_clean, desc = "Clean" },
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
vim.keymap.set({ "i" }, "<C-x><C-f>", function()
    require("fzf-lua").complete_path()
end, { silent = true, desc = "Fuzzy complete path" })

wk.add({
    { "s", group = "surround" },
    { "<leader>q", group = "query" },
    { "<leader>qq", "<cmd>FzfLua grep<cr>", desc = "Grep" },
    { "<leader>qw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word" },
    { "<leader>qv", "<cmd>FzfLua grep_visual<cr>", desc = "Grep visual" },
})

local toggle_hint = function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
wk.add({
    { "t", group = "toggle" },
    { "th", toggle_hint, desc = "inlay hint" },
    { "tw", "<cmd>set wrap!<cr>", desc = "wrap" },
    { "ts", "<cmd>set spell!<cr>", desc = "spell" },
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
    { "<leader>ghs", "<cmd>Gitsigns stash_hunk<cr>", desc = "stash", mode = { "n", "v" } },
    { "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Unstage", mode = { "n", "v" } },
    { "<leader>gl", group = "Log" },
    { "<leader>ghu", "<cmd>Glog -1<cr>", desc = "Unstage", mode = { "n", "v" } },
})
