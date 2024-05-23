return {
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup()
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    'nvim-lua/plenary.nvim',
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = true,
        opts = ...
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            -- vim.cmd([[colorscheme tokyonight]])
        end,
    },
    'tpope/vim-commentary',
    {
        'tpope/vim-fugitive',
        keys = {
            { "<leader>gb", "<cmd>Git blame<cr>",     desc = "Blame" },
            { "<leader>gd", "<cmd>Git difftool<cr>",  desc = "Difftool" },
            { "<leader>gm", "<cmd>Git mergetool<cr>", desc = "Mergetool" },
        },
    },
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'tpope/vim-dispatch',
    -- 'easymotion/vim-easymotion', TODO: find alternatives
    {
        'vimwiki/vimwiki',
        keys = {
            { "<leader>vw", "<cmd>VimwikiIndex<cr>", desc = "Vimwiki" },
        },
    },
    {
        'gfanto/fzf-lsp.nvim',
        config = function()
            require('fzf_lsp').setup()
        end,
        keys = {
            { "<leader>f", "<cmd>GFiles<cr>",  desc = "Files" },
            { "<leader>b", "<cmd>Buffers<cr>", desc = "Open files" },
            { "<leader>F", "<cmd>Files<cr>",   desc = "ALL Files" },
        },
        dependencies = { 'junegunn/fzf', 'junegunn/fzf.vim' },
    },
}
