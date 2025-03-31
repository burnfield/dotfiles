-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.scrolloff = 3
vim.o.sidescrolloff = 2
vim.o.linebreak = true
vim.o.textwidth = 80
vim.o.swapfile = false
vim.o.wrap = false
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
vim.o.signcolumn="yes"

-- Searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- Folding
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99

vim.cmd([[set directory^=$HOME/.vim/tmp//]])
vim.cmd([[set completeopt=menu,fuzzy,noinsert,menuone,popup]])

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
