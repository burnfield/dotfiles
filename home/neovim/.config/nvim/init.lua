vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<cr>', {desc='source vimrc'})
vim.keymap.set('n', '<leader>ev', ':e $MYVIMRC<cr>', {desc='edit vimrc'})
vim.keymap.set('n', '<C-s>', ':w<cr>')

-- settings
vim.o.scrolloff=3
vim.o.sidescrolloff=2
vim.o.linebreak=true
vim.o.textwidth=80
vim.o.swapfile=false
vim.o.wrap=false
vim.cmd [[set clipboard+=unnamedplus]]

-- Spaces and tabs
vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.shiftround=true
vim.o.smartindent=true
vim.o.expandtab=true

-- Ui
vim.o.bg=light
vim.o.termguicolors=true
vim.o.cc="121"
vim.o.splitright=true
vim.o.list=true
vim.cmd [[highlight ColorColumn ctermbg=0 guibg=lightgrey]]

-- Searching
vim.o.ignorecase=true
vim.o.smartcase=true

-- Folding
vim.o.foldmethod="indent"
vim.o.foldlevel=99

vim.cmd [[set directory^=$HOME/.vim/tmp//]]

vim.o.grepprg="rg --vimgrep --no-heding"
vim.o.grepformat="%f:%l:%c:%m,%f:%l:%m"

-- Avoid showing message extra message when using completion
vim.cmd [[set shortmess+=c]]
vim.cmd [[set complete-=i]]
vim.o.completeopt=menu,menuone,noinsert,noselect

require("lazy").setup("plugins")
vim.o.background = "light" -- or "light" for light mode
vim.cmd([[colorscheme catppuccin-latte]])
require"lspconfig".rust_analyzer.setup{}
require"lspconfig".lua_ls.setup{}
