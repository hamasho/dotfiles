" Basic configuration {{{1
set nocompatible
syntax on
filetype off
set hidden

" Use true colour in vim
" detail:
" https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
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
set formatoptions+=j
set fillchars+=vert:\ 
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
" Always display the status line, even if only one window is displayed
set laststatus=2
" Rise a dialogue asking if you wish to save changed files.
set confirm
set visualbell
set t_vb=
set cursorline
set cursorcolumn
set scrolloff=99
set sidescrolloff=5
set lazyredraw
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
"set cmdheight=1
set number relativenumber
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
" Folding
set foldenable
set foldlevelstart=10   " open most folds by default
set foldmethod=syntax
set shortmess=atIT
set showtabline=1
set ttyfast
set history=2000
set switchbuf=useopen
set t_Co=256
" set background=light
set background=dark

" Change <leader> to ','
let mapleader = ","

" Plugin manager {{{1

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

""" Appearance

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Nice status & tab line
Plugin 'itchyny/lightline.vim'

" Colors
Plugin 'flazz/vim-colorschemes'
Plugin 'shinchu/lightline-gruvbox.vim'
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \     'left': [ [ 'mode', 'paste' ],
    \               [ 'gitbranch', 'readonly', 'relativepath', 'tagbar',
    \                  'modified'] ],
    \     'right': [ [ 'fileencoding', 'filetype' ],
    \                [ 'percent' ] ]
    \ },
    \ 'inactive': {
    \     'left': [ [ 'filename', 'modified'] ],
    \     'right': [ [ 'percent' ] ]
    \ },
    \ 'component' : {
    \     'tagbar': '%{tagbar#currenttag("%s", "", "f")}'
    \ },
    \ 'component_function': {
    \     'gitbranch': 'fugitive#head',
    \ },
    \ 'tabline': {
    \     'left': [ [ 'tabs' ] ],
    \     'right': [ [ ] ],
    \ },
\ }

" Pretty file type icons
Plugin 'ryanoasis/vim-devicons'

""" Misc

" NERDTree
Plugin 'scrooloose/nerdtree'
let NERDTreeHijackNetrw = 1
nnoremap <leader>n :e .<cr>

" CtrlP
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = '\v[\/]node_modules$'
let g:ctrlp_extensions = ['tag']

" Open browser easily
Plugin 'tyru/open-browser.vim'
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" Easy motion
Plugin 'easymotion/vim-easymotion'
map s <plug>(easymotion-s)
map <leader>s <plug>(easymotion-overwin-f)

" Jump to various pairs
Plugin 'tpope/vim-unimpaired'

" Find closing pair
Plugin 'adelarsq/vim-matchit'

" Great search
Plugin 'tpope/tpope-vim-abolish'

" Async search
Plugin 'mhinz/vim-grepper'
nnoremap <leader>g :Grepper<cr>

" Git helper
Plugin 'tpope/vim-fugitive'

""" Editing

" Easy align
Plugin 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Surround
Plugin 'tpope/vim-surround'

" Easy comment
Plugin 'vim-scripts/tComment'

" Automatic closing
Plugin 'jiangmiao/auto-pairs'

" Indentation level selecting
Plugin 'michaeljsmith/vim-indent-object'

""" Coding

" Code tags in page
Plugin 'majutsushi/tagbar'
nnoremap <leader>t :TagbarToggle<cr>

" TODO: check vim-easytags slow down python files after first save
" Automatic update ctags
" Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-easytags'

" Easy tag navigation
Plugin 'devjoe/vim-codequery'

" Ultimate snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Complete source
" Plugin 'maralla/completor.vim'

" Async syntax checker
Plugin 'w0rp/ale'
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
\ 'python': ['pylint'],
\ 'typescript': ['tslint'],
\ 'c': [],
\}

" JasvScript
Plugin 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1
let g:javascript_opfirst = 1
Plugin 'ternjs/tern_for_vim'

Plugin 'posva/vim-vue'

Plugin 'mustache/vim-mustache-handlebars'

" TypeScript
Plugin 'leafgarland/typescript-vim'
augroup TypeScript
    au!
    au FileType typescript
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2     |
        \ setlocal shiftwidth=2
augroup END

" Emmet (Zen cording HTML)
Plugin 'mattn/emmet-vim'

" Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_toc_autofit = 1
set conceallevel=0
augroup MarkDown
    au!
    au FileType markdown
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2     |
        \ setlocal shiftwidth=2
augroup END

" Python
" Plugin 'klen/python-mode'
" let g:pymode_options_max_line_length = 80
" let g:pymode_rope = 0
" let g:pymode_lint = 0

Plugin 'Vimjas/vim-python-pep8-indent'

" Kubernetes
Plugin 'c9s/helper.vim'
Plugin 'c9s/treemenu.vim'
Plugin 'c9s/vikube.vim'
Plugin 'andrewstuart/vim-kubernetes'

call vundle#end()

" Basic autocmd {{{1

" Useful for my Quick Notes feature in my tmuxrc
augroup LoadOnce
    au!
    " Don't replace Tabs with spaces when editing makefiles
    au Filetype makefile setlocal noexpandtab
    " Auto reload .vimrc after saving
    au BufWritePost .vimrc :source ~/.vimrc
    au BufReadPost .vimrc :set foldmethod=marker
    au BufNewFile,BufRead *.html set ft=jinja

    " Check if file is edited outside vim
    au CursorHold * checktime
augroup END

" Frequently editing files {{{1

nnoremap 'f :e ~/.vimperatorrc<cr>
nnoremap 'v :e ~/.vimrc<cr>
nnoremap 'z :e ~/.zshrc<cr>

" Commands {{{1

nnoremap j gj
nnoremap k gk
" press F4 to fix indentation in whole file; overwrites marker 'q' position
noremap <F4> mqggVG=`qzz
inoremap <F4> <Esc>mqggVG=`qzza
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

" HTML {{{2
augroup HTML
    au!
    au FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" Pug {{{2
Plugin 'digitaltoad/vim-pug'

" Stylus {{{2
Plugin 'wavded/vim-stylus'

" Jinja2 {{{2
" Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'lepture/vim-jinja'
augroup Jinja
    au!
    au FileType jinja
      \ setlocal softtabstop=2 |
      \ setlocal tabstop=2     |
      \ setlocal shiftwidth=2
augroup END

" Python {{{2
augroup PYTHON
    au!
    au BufRead *.py setlocal foldmethod=indent
    au BufNewFile *.py setlocal foldmethod=indent
augroup END

" Ruby {{{2
augroup RUBY
    au!
    au FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
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

augroup VUE
    au!
    au BufRead *.vue setlocal shiftwidth=2 tabstop=2 softtabstop=2
    au BufNewFile *.vue setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" YAML {{{2
augroup YAML
    au!
    au FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" All files {{{2
augroup ApplyAll
    au!
    au BufRead * setlocal breakindent breakindentopt=shift:2
    au BufReadPost * if line("'\"'") > 0 && line("'\"'") <= line("$") | exe "normal! g'\"" | endif
    au BufNewFile * setlocal breakindent breakindentopt=shift:2
augroup END

" Set colors {{{1

colorscheme gruvbox
let g:gruvbox_italic = 0
let g:gruvbox_invert_selection = 0
let g:gruvbox_contrast_dark = "hard"

hi Normal guibg=NONE ctermbg=NONE
hi Normal guifg=NONE ctermfg=NONE
hi LineNr ctermbg=238 guibg=#444444
hi VertSplit ctermbg=238 guibg=#444444
hi Visual cterm=bold
syn match Braces display '[{}()\[\]]'

filetype indent plugin on
