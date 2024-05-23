return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufReadPost', 'BufNewFile' },
    keys = {
      { "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover" },
      { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Definition" },
      { "gD", "<cmd>lua vim.lsp.buf.declarations()<cr>", desc = "Declarations" },
      { "gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "References" },
      { "gs", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
      { "g0", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", desc = "Document Symbols" },
      { "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", desc = "Workspace Symbols" },
      { "g.", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
      { "<leader>gf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", desc = "Format" },
    },
    dependencies = {  { 'folke/neodev.nvim', opts = {} } },
    config = function()
        require('neodev').setup()
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = { "clangd", "ruff_lsp" },
            handlers = {
                function (server_name)
                    require("lspconfig")[server_name].setup {}
                end,
            },
        })
    end,
  },
  {
    'williamboman/mason.nvim',
    build = ":MasonUpdate",
    cmd = "Mason",
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
  },
}
