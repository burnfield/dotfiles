call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'gfanto/fzf-lsp.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'lvimuser/lsp-inlayhints.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter',

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'

Plug 'SmiteshP/nvim-navic'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }

Plug 'ms-jpq/coq_nvim'
Plug 'ms-jpq/coq.artifacts', { 'branch': 'artifacts' }
Plug 'ms-jpq/coq.thirdparty', { 'branch': '3p' }

Plug 'easymotion/vim-easymotion'
Plug 'vimwiki/vimwiki'
Plug 'lewis6991/spellsitter.nvim'
call plug#end()

packadd termdebug
let g:termdebug_wide = 163

filetype plugin on
filetype indent on

" settings
set scrolloff=3
set sidescrolloff=2
set linebreak
set textwidth=80
set noswapfile
set clipboard+=unnamedplus

" Spaces and tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set smartindent
set expandtab

" Ui
colorscheme onenord
set cc=81
highlight ColorColumn ctermbg=0 guibg=lightgrey
set splitright
set list
lua require'nvim-treesitter.configs'.setup{highlight = {enable = true}}

" Searching
set ignorecase
set smartcase

" Folding
set foldmethod=indent
set foldlevel=99

set directory^=$HOME/.vim/tmp//

set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m,%f:%l:%m

" Avoid showing message extra message when using completion
set shortmess+=c
set complete-=i
set completeopt=menu,menuone,noinsert,noselect
let g:coq_settings = { 'auto_start': 'shut-up' } " note: edited coq_nvim/config/default.yml to remove c-h and c-k

lua vim.diagnostic.config({ virtual_text = false })

lua <<EOF
require("lsp-inlayhints").setup()
local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  require("lsp-inlayhints").on_attach(client, bufnr)
end

require("lualine").setup({
  winbar = {
    lualine_a = {
      { 'filename' },
    },
    lualine_b = {
      { navic.get_location, cond = navic.is_available },
    },
  },
  inactive_winbar = {
    lualine_a = {
      { 'filename' },
    },
  },
  sections = {
    lualine_c = {},
  },
  inactive_sections = {
    lualine_b = {'branch'}
  },
})

local coq = require'coq'
local lsp = require'lspconfig'

lsp.pylsp.setup{
  on_attach = on_attach,
  coq.lsp_ensure_capabilities{}
}

lsp.veridian.setup{
  on_attach = on_attach,
  coq.lsp_ensure_capabilities{}
}

lsp.clangd.setup{
  on_attach = on_attach,
  coq.lsp_ensure_capabilities{}
}

lsp.rust_analyzer.setup({
  on_attach=on_attach,
  coq.lsp_ensure_capabilities{}
})

require'fzf_lsp'.setup()
EOF

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.5, 'relative': v:true, 'padding': 0, 'margin': 0 } }
let g:fzf_preview_window = ['right,50%,<70(down,50%),border-none', 'ctrl-/']

"" bindings:
let mapleader = " "
nnoremap gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gH <cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gh <cmd>lua require('lsp-inlayhints').toggle()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.declarations()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gs <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap g. <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap g. <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>= <cmd>lua vim.lsp.buf.format({async = true})<CR>

nnoremap <leader>vw <cmd>VimwikiIndex<CR>


" Navigate quickfix list and location list
let g:quickfix_is_open = 0
function! QuickfixToggle()
  if g:quickfix_is_open
      cclose
      let g:quickfix_is_open = 0
  else
      copen
      let g:quickfix_is_open = 1
  endif
endfunction
nnoremap <c-j> <cmd>cnext<cr>
nnoremap <c-k> <cmd>cprev<cr>
nnoremap <c-l> <cmd>call QuickfixToggle()<cr>

" save ctrl + s
nnoremap <c-s> <cmd>w<cr>
inoremap <c-s> <cmd>w<cr>
vnoremap <c-s> <cmd>w<cr>

nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gd :Git difftool<cr>
nnoremap <leader>gs :GitGutterStageHunk<cr>
nnoremap <leader>gm :Git mergetool<cr>
nnoremap <leader>gr :GitGutterUndoHunk<cr>

nmap <leader>f :GFiles<cr>
nmap <leader>F :Files<cr>
nmap <leader>b :Buffers<cr>

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-bd-f)
vmap s <Plug>(easymotion-bd-f)
omap s <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-sl)
vmap f <Plug>(easymotion-sl)
omap f <Plug>(easymotion-sl)

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! TrimWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

set autoread
augroup init_group
    autocmd!
    autocmd BufWritePost *.cc, *.hh, *.cpp silent :!git diff -U0 --no-color --relative HEAD^ % | /usr/bin/clang-format-diff-13 -p1 -i
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

    autocmd BufWritePost *.py silent :!darker % -l 80
    autocmd BufWritePre *.rs lua vim.lsp.buf.format()

    au BufWritePre      *.py,*.v,*.hh,*.cc,*.sv,*.svh :call TrimWhitespace()
    autocmd FileType rust compiler cargo
augroup END
