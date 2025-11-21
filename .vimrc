" Basic configuration {{{1
set nocompatible
syntax on
filetype off
set hidden

" " Use true colour in vim
" " https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Better command-line completion
set wildmenu
set complete-=i
set showcmd " Show partial commands in the last line of the screen
set encoding=utf-8 " encoding used for displaying file
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis " encoding when saving
set fileformats=unix,dos,mac
set showmatch " highlight matching braces
set showmode " show insert/replace/visual mode
set noswapfile
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set formatoptions+=jmM
set fillchars+=vert:│
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set autoread
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
set autoindent
set cindent
set nostartofline
set noruler
" Display status line for current buffer only
set laststatus=2
set cmdheight=1
set number relativenumber
set numberwidth=3
" Rise a dialogue asking if you wish to save changed files.
set confirm
set visualbell
set t_vb=
set cursorline
set scrolloff=99
set sidescrolloff=5
set lazyredraw
set nowrap
set nrformats-=octal
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
set nobackup " do not keep the backup~ file
set backupcopy=yes " directly write on file, instead of create new file and move
set expandtab " fill tabs with spaces
set nojoinspaces " no extra space after '.' when joining lines
set shiftwidth=4 " set indentation depth to 4 columns
set softtabstop=4 " backspacing over 4 spaces like over tabs
set tabstop=4 " set tabulator length to 4 columns
set shortmess=atIT
set showtabline=1
set ttyfast
set history=2000
set switchbuf=useopen
set t_Co=256
set mouse=a
set background=dark
set updatetime=300

" Change <leader> to ','
let mapleader = ","

" Plugin manager {{{1

call plug#begin()

""" Appearance
Plug 'nvim-lualine/lualine.nvim'

""" Coding

" Native LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'

""" Misc

" Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap FF <cmd>Telescope find_files<cr>
nnoremap FA <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>n :Telescope file_browser<cr>

" Open browser easily
Plug 'tyru/open-browser.vim'
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)

" Easy motion
Plug 'easymotion/vim-easymotion'
map s <plug>(easymotion-s)
map <leader>s <plug>(easymotion-overwin-f)

" Jump to various pairs
Plug 'tpope/vim-unimpaired'
" Find closing pair
Plug 'adelarsq/vim-matchit'

" Great search
Plug 'tpope/tpope-vim-abolish'

""" Editing
" Surround
Plug 'tpope/vim-surround'

" Easy comment
Plug 'vim-scripts/tComment'

" Colorize parentheses/blackets
Plug 'frazrepo/vim-rainbow'
let g:rainbow_active = 1

" Colorize hex
Plug 'ap/vim-css-color'

" Automatic closing
Plug 'jiangmiao/auto-pairs'

" Indentation level selecting
Plug 'michaeljsmith/vim-indent-object'

""" Coding

" Better syntax highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Emmet (Zen coding HTML)
Plug 'mattn/emmet-vim'

" Language-specific indentation
augroup FileTypeIndentation
    au!
    au FileType typescript,typescriptreact,javascript,javascriptreact,json,html,css setlocal softtabstop=2 tabstop=2 shiftwidth=2
augroup END

" Colors
Plug 'shaunsingh/nord.nvim'

call plug#end()

lua << EOF
-- Lualine
require('lualine').setup {
    options = { icons_enabled = false },
    sections = {
        lualine_c = {
            { 'filename', path = 1 }
        }
    }
}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "vim", "python", "html", "typescript", "tsx", "javascript" },
  highlight = { enable = true },
  indent = { enabled = true },
}

-- Completion
local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then return end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- LSP setup
local lspconfig_ok, _ = pcall(require, 'lspconfig')
if lspconfig_ok then
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Python
  vim.lsp.config.pyright = { capabilities = capabilities }

  -- TypeScript/JavaScript
  vim.lsp.config.ts_ls = { capabilities = capabilities }

  -- JSON
  vim.lsp.config.jsonls = { capabilities = capabilities }

  -- Enable LSP servers
  vim.lsp.enable({'pyright', 'ts_ls', 'jsonls'})
end

-- LSP keybindings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
  end,
})
EOF

" Folding
set foldenable
set foldlevelstart=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Basic autocmd {{{1

" Useful for my Quick Notes feature in my vimrc
augroup LoadOnce
    au!
    " Auto reload .vimrc after saving
    au BufWritePost .vimrc nested :source ~/.vimrc
    " Check if file is edited outside vim
    au CursorHold * checktime
augroup END

" Commands {{{1

nnoremap j gj
nnoremap k gk
noremap Y y$
nnoremap <c-l> :noh<cr>
" toggle folding
nnoremap <space> za
" Toggle ; and : (don't want to push SHIFT!)
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <c-c> :bp\|bd #<cr>
nnoremap <c-e> $
vnoremap <c-e> $h
nnoremap <c-s> :w<cr>

nnoremap <c-n> "+
vnoremap <c-n> "+

" Replace all word under the cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/
" Copy entire text
nnoremap <Leader>c ggVG"+y''<c-o>

" Ritch key bindings in insert mode
inoremap <c-f> <right>
inoremap <c-b> <left>
inoremap <c-h> <delete>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-s> <esc>:w<cr>

" Ritch key bindings in command mode
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-f> <right>
cnoremap <c-b> <left>
cnoremap <c-h> <delete>
cnoremap <c-a> <home>
cnoremap <c-e> <end>

command! Q :mksession! | qa

" For each filetype {{{1

" Git Commit {{{2
augroup GitCommit
    au!
    au FileType gitcommit setlocal tw=200
augroup END

" HTML {{{2
augroup HTML
    au!
    au FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" Python {{{2
augroup PYTHON
    au!
    au FileType python let b:coc_root_patterns = ['main.py', '.git', '.env']
augroup END

" CSS {{{2
augroup CSS
    au!
    au BufRead *.css,*.scss setlocal shiftwidth=2 tabstop=2 softtabstop=2
    au BufNewFile *.css,*.scss setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" Json {{{2
augroup JSON
    au!
    au BufRead *.json setlocal shiftwidth=2 tabstop=2 softtabstop=2
    au BufNewFile *.json setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" JavaScript {{{2
augroup JS
    au!
    au BufRead *.js setlocal shiftwidth=2 tabstop=2 softtabstop=2
    au BufNewFile *.js setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" YAML {{{2
augroup YAML
    au!
    au FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" Quickfix {{{2
augroup Quickfix
    au!
    au FileType qf setlocal wrap
augroup END

" All files {{{2
augroup ApplyAll
    au!
    au BufRead * setlocal breakindent breakindentopt=shift:2
    au BufReadPost * if line("'\"'") > 0 && line("'\"'") <= line("$") | exe "normal! g'\"" | endif
    au BufNewFile * setlocal breakindent breakindentopt=shift:2
augroup END

" Set colors {{{1

colorscheme nord
highlight Normal guibg=NONE ctermbg=NONE

filetype indent plugin on
