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

" For code complition (language server, LSP)
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-tsserver',
    \ 'coc-pyright',
\ ]

" GoTo code navigation.
nmap <silent> <c-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

""" Misc

" For fuzzy find everything
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
nnoremap <C-p><C-f> <cmd>Telescope find_files<cr>
nnoremap <C-p><C-g> <cmd>Telescope live_grep<cr>
nnoremap <C-p><C-b> <cmd>Telescope buffers<cr>

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p><c-p>'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = 'node_modules\|__pycache__\|vendor\|dist\|venv'

" NERDTree
Plug 'scrooloose/nerdtree'
let NERDTreeHijackNetrw = 1
nnoremap <leader>n :e .<cr>
nnoremap <leader>N :NERDTreeFind<cr>

" fzf
" install: fzf#install()
set rtp+=/opt/homebrew/opt/fzf
Plug 'junegunn/fzf.vim'
nnoremap FF :Files<cr>
nnoremap FA :Ag<cr>

" Project EditorConfig
Plug 'editorconfig/editorconfig-vim'

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

" Async search
Plug 'mhinz/vim-grepper'
let g:grepper = {
\     'tools': ['ag', 'git'],
\ }
nnoremap <leader>g :Grepper<cr>

" Local search with index number
Plug 'henrik/vim-indexed-search'

" Git helper
" All git command battery included!
Plug 'tpope/vim-fugitive'
" Handler for :GBrowse to open files on github
Plug 'tpope/vim-rhubarb'
" Mark modified lines
" Plug 'airblade/vim-gitgutter'
" let g:gitgutter_enabled = 0
Plug 'tyru/open-browser-github.vim'
nnoremap <leader>o :OpenGithubFile<cr>
noremap <leader>O :'<,'>OpenGithubFile<cr>

""" Editing

" Easy align
Plug 'junegunn/vim-easy-align'
let g:easy_align_delimiters = {
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment'] },
\ ']': {
\     'pattern':       '[[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   }
\ }
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Surround
Plug 'tpope/vim-surround'

" Easy comment
Plug 'vim-scripts/tComment'

" Text table
Plug 'dhruvasagar/vim-table-mode'

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

" Async syntax checker
Plug 'w0rp/ale'
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {
\ 'python': ['pylint', 'mypy'],
"\ 'python': ['pylint', 'flake8', 'mypy'],
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'typescriptreact': ['eslint', 'stylelint'],
\ 'graphql': [],
\ 'ruby': ['rubocop'],
\ 'c': [],
\}
let g:ale_fixers = {
\ '\.js$': ['eslint', 'prettier'],
\ 'javascript': ['eslint', 'prettier'],
\ 'python': ['black', 'isort'],
\ 'typescript': ['eslint', 'prettier'],
\ 'typescriptreact': ['eslint', 'prettier', 'stylelint'],
\ 'typescript.tsx': ['eslint', 'prettier', 'stylelint'],
\ 'vue': ['prettier'],
\ 'ruby': ['rubocop'],
\ '\.spec\.js$': [],
\ '*': [],
\}

" Better syntax highlight and more
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" JasvScript
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1
Plug 'leafOfTree/vim-vue-plugin'

" TypeScript
Plug 'leafgarland/typescript-vim'
let g:tsuquyomi_use_vimproc = 1
augroup TypeScript
    au!
    au FileType typescript
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2     |
        \ setlocal shiftwidth=2
augroup END

augroup TypeScriptTsx
    au!
    au BufNewFile,BufRead *.tsx set filetype=typescript.tsx
    au FileType typescript.tsx
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2     |
        \ setlocal shiftwidth=2
    au FileType typescriptreact
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2     |
        \ setlocal shiftwidth=2
augroup END

" JSX
Plug 'maxmellon/vim-jsx-pretty'

" Styled component
Plug 'styled-components/vim-styled-components'

" Emmet (Zen cording HTML)
Plug 'mattn/emmet-vim'

" Prisma
Plug 'prisma/vim-prisma'

" Ruby
Plug 'tpope/vim-rails'

" SuperCollider
Plug 'davidgranstrom/scnvim'

" TidalCycle
Plug 'tidalcycles/vim-tidal'

" Markdown
Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'mzlogin/vim-markdown-toc'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_toc_autofit = 1
set conceallevel=0
augroup MarkDown
    au!
    au FileType markdown
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2     |
        \ setlocal shiftwidth=2  |
        \ setlocal wrap
augroup END

" Colors
Plug 'shaunsingh/nord.nvim'

call plug#end()

lua << END
require('lualine').setup {
    options = {
        icons_enabled = false,
    },
    sections = {
        lualine_c = {
            {
                    'filename',
                    path = 1,
                }
            }
    }
}
END

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "vim", "python", "html", "typescript", "tsx", "javascript" },

  highlight = {
    enable = true,
  },
  indent = {
    enabled = true,
  },
}
EOF

" SuperCollider
lua << EOF
require('scnvim').setup({})
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
