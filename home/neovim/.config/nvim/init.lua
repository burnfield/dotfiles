require("config.lazy")
vim.lsp.enable({ "basedpyright" })
-- require('mini.completion').setup()
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method("textDocument/implementation") then
    end

    if client:supports_method("textDocument/completion") then
      local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      client.server_capabilities.completionProvider.triggerCharacters = chars

      vim.lsp.completion.enable(
        true,
        client.id,
        args.buf,
        { autotrigger = true }
      )
    end
  end,
})

-- local vim = vim
-- local Plug = vim.fn["plug#"]
--
-- vim.call("plug#begin")
-- Plug("neovim/nvim-lspconfig")
-- Plug("kosayoda/nvim-lightbulb")
-- Plug("junegunn/vim-easy-align")
-- Plug("folke/which-key.nvim") --  TODO(Oskar): fixa leaders
-- Plug("nvim-tree/nvim-web-devicons")
-- -- TODO: linter
-- -- TODO: zen
-- -- TODO: git signs make sure to reuse treesitter jump thingy
-- vim.call("plug#end")
--
-- -- Color schemes should be loaded after plug#end().
-- vim.cmd([[colorscheme catppuccin-mocha]])
-- vim.o.bg = dark
-- -- We prepend it with 'silent!' to ignore errors when it's not yet installed.
--
-- vim.keymap.set(
--   "n",
--   "<leader>sv",
--   ":source $MYVIMRC<cr>",
--   { desc = "source vimrc" }
-- )
-- vim.keymap.set("n", "<leader>ev", ":e $MYVIMRC<cr>", { desc = "edit vimrc" })
-- vim.keymap.set("n", "<C-s>", ":w<cr>")
--
-- -- settings
-- vim.o.scrolloff = 3
-- vim.o.sidescrolloff = 2
-- vim.o.linebreak = true
-- vim.o.textwidth = 80
-- vim.o.swapfile = false
-- vim.o.wrap = false
-- vim.o.cmdheight = 0
-- vim.cmd([[set clipboard+=unnamedplus]])
--
-- -- Spaces and tabs
-- vim.o.tabstop = 2
-- vim.o.softtabstop = 2
-- vim.o.shiftwidth = 2
-- vim.o.shiftround = true
-- vim.o.smartindent = true
-- vim.o.expandtab = true
--
-- -- Ui
-- vim.o.termguicolors = true
-- vim.o.splitright = true
-- vim.o.list = true
--
-- -- Searching
-- vim.o.ignorecase = true
-- vim.o.smartcase = true
--
-- -- Folding
-- vim.o.foldmethod = "indent"
-- vim.o.foldlevel = 99
--
-- vim.cmd([[set directory^=$HOME/.vim/tmp//]])
--
-- vim.o.grepprg = "rg --vimgrep --no-heading"
-- vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
--
-- -- Avoid showing message extra message when using completion
-- vim.cmd([[set shortmess+=c]])
-- vim.cmd([[set complete-=i]])
-- vim.o.completeopt = menu, menuone, noinsert, noselect
--
-- vim.g.vimwiki_list =
--   { {
--     path = "~/vimwiki/",
--     syntax = "markdown",
--     ext = "md",
--   } }
--
--
-- -- Code action
-- require("nvim-lightbulb").setup({
--   autocmd = { enabled = true },
--   virtual_text = { enabled = true },
--   sign = { enabled = false },
-- })
--
-- -- FZF
-- require("fzf-lua").setup({
--   hls = { border = "FloatBorder" },
--   winopts = { backdrop = 100 },
-- })
-- -- vim.g.fzf_layout = { tmux = "bottom,40%" }
--
-- -- treesitter
-- require("nvim-treesitter.configs").setup()
--
-- --  TODO(Oskar): fixa repeat for signs
-- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
-- vim.keymap.set(
--   { "n", "x", "o" },
--   "f",
--   ts_repeat_move.builtin_f_expr,
--   { expr = true }
-- )
-- vim.keymap.set(
--   { "n", "x", "o" },
--   "F",
--   ts_repeat_move.builtin_F_expr,
--   { expr = true }
-- )
-- vim.keymap.set(
--   { "n", "x", "o" },
--   "t",
--   ts_repeat_move.builtin_t_expr,
--   { expr = true }
-- )
-- vim.keymap.set(
--   { "n", "x", "o" },
--   "T",
--   ts_repeat_move.builtin_T_expr,
--   { expr = true }
-- )
--
-- -- LSP
-- -- LSP - keybinds
-- -- TODO(Oskar): anvand bara om lsp aktiv, annars treesitters
-- vim.keymap.set(
--   { "n", "v" },
--   "<leader>th",
--   ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
--   { desc = "ToggleHints" }
-- )
--
-- -- LSP - Python
-- require("lspconfig").basedpyright.setup({
--   settings = {
--     basedpyright = {
--       analysis = {
--         typeCheckingMode = "basic",
--       },
--     },
--   },
-- })
-- require("lspconfig").ruff.setup({
--   init_options = {
--     settings = {
--       fixAll = false,
--       organizeImports = false,
--     },
--   },
-- })
--
-- -- set formatter lua !stylua --indent-type spaces --indent-width 2 --column-width 100 %
--
-- vim.diagnostic.config({
--   virtual_text = false,
--   signs = true,
--   update_in_insert = true,
--   underline = true,
-- })
