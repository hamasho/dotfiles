" Basic configuration {{{1
set nocompatible
syntax on
filetype off
set hidden
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
set fillchars+=vert:│
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
" Always display the status line, even if only one window is displayed
set laststatus=2
" Rise a dialogue asking if you wish to save changed files.
set confirm
set visualbell
set t_vb=
"set cursorline
set nocursorcolumn
set scrolloff=99
set sidescrolloff=5
set lazyredraw
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
"set cmdheight=1
set number
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
"set showtabline=2
"set statusline=%t\ %m\ %y\ %r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}\ %{getfperm(@%)}]\ %12.(%c:%l/%L%)\ \(%p%%)
set ttyfast
set history=2000
set switchbuf=useopen

" Change <leader> to ','
let mapleader = ","
" " Enable Alt-? mapping by <m-?>
" for c in map(range(char2nr('a'), char2nr('z')), 'nr2char(v:val)')
"     execute "set <m-".c.">=\e".c
" endfor

" Plugin manager {{{1

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Powerline
Plugin 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'unicode'
let g:Powerline_stl_path_style = 'short'

" Solarized color
" Plugin 'altercation/vim-colors-solarized'
" And other colors
Plugin 'flazz/vim-colorschemes'

" Collaboration with tmux
Plugin 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-w><c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-w><c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-w><c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-w><c-l> :TmuxNavigateRight<cr>

" YouCompleteMe
" Plugin 'Valloric/YouCompleteMe'

" NERDTree
Plugin 'scrooloose/nerdtree'
let NERDTreeHijackNetrw = 1
nnoremap <leader>n :e .<cr>

" Easy align
Plugin 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Easy comment
Plugin 'vim-scripts/tComment'

" Match it
Plugin 'adelarsq/vim-matchit'

" Great search
Plugin 'tpope/tpope-vim-abolish'

" Syntax check
Plugin 'scrooloose/syntastic'
let g:syntastic_javascript_checkers = ['eslint']

" Git helper
Plugin 'tpope/vim-fugitive'

" Ultimate snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Vdebug
Plugin 'joonty/vdebug.git'
augroup VDEBUG
    au!
    au FileType php let g:vdebug_options["break_on_open"] = 0
augroup END

" Automatic closing
Plugin 'jiangmiao/auto-pairs'

" JasvScript
Plugin 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1
Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0
Plugin 'ternjs/tern_for_vim'

" Emmet (Zen cording HTML)
Plugin 'mattn/emmet-vim'

" VimWiki
Plugin 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/.vimwiki/'}]

" Ag support
Plugin 'rking/ag.vim'

" CtrlP
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_working_path_mode = 'ar'
let g:ctrlp_custom_ignore = '\v[\/]node_modules$'
nnoremap <leader>p :CtrlPBuffer<cr>
nnoremap <leader><leader>p :CtrlPMRU<cr>

" Easy motion
Plugin 'easymotion/vim-easymotion'
map s <plug>(easymotion-s)
map <leader>s <plug>(easymotion-overwin-f)

" Surround
Plugin 'tpope/vim-surround'

" Open browser easily
Plugin 'tyru/open-browser.vim'
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" Ritch calender
Plugin 'itchyny/calendar.vim'

" Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_toc_autofit = 1
set conceallevel=0
augroup MarkDown
    au!
    "au BufRead /home/shinsuke/Documents/memo/* :nnoremap buffer <c-]> call OpenLinkedFIle<cr>
    au FileType markdown
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2     |
        \ setlocal shiftwidth=2
augroup END

" Python
Plugin 'klen/python-mode'
let g:pymode_options_max_line_length = 80
let g:pymode_rope = 0
let g:pymode_lint = 0
let g:syntastic_python_checkers = ['python', 'pylint', 'pyflakes']

" Jinja2
Plugin 'Glench/Vim-Jinja2-Syntax'

" LanguageTool: spell chacker
" Plugin 'vim-scripts/LanguageTool'
" let g:languagetool_jar = "/home/shinsuke/bin/LanguageTool-2.9/languagetool-commandline.jar"
" nnoremap gc :LanguageToolCheck<cr>

call vundle#end()

" Basic autocmd {{{1

" Useful for my Quick Notes feature in my tmuxrc
augroup LoadOnce
    au!
    au BufWrite,VimLeave * mkview
    au BufRead           * silent loadview
    " don't replace Tabs with spaces when editing makefiles
    au Filetype makefile setlocal noexpandtab
    au BufWritePost .vimrc :source ~/.vimrc
    au BufReadPost .vimrc :set foldmethod=marker
augroup END

" Frequently editing files {{{1
nnoremap 'f :e ~/.vimperatorrc<cr>
nnoremap 'm :e ~/doc/memo.md<cr>
nnoremap 't :e ~/doc/todos.md<cr>
nnoremap 'g :e ~/doc/gtd.md<cr>
nnoremap 'v :e ~/.vimrc<cr>
nnoremap 'w :e ~/doc/memo/index.md<cr>
nnoremap 's :e ~/doc/memo/scratch.md<cr>
nnoremap 'c :e ~/doc/memo/mint-config.md<cr>
nnoremap 'z :e ~/.zshrc<cr>
nnoremap 'r :e ~/doc/jobhunt/schedule.md<cr>

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
nnoremap <leader>a a_<esc>r
nnoremap <c-s> :w<cr>
inoremap <c-s> <esc>:w<cr>

command! Q :mksession! | qa

" For each filetype {{{1

" Ruby {{{2
augroup Ruby
    au!
    au FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" PHP {{{2
augroup PHP
    au!
    nnoremap <leader>t :!phpunit %<cr>
augroup END

" HTML {{{2
augroup HTML
    au!
    au FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" Python {{{2
augroup PYTHON
    au!
    au FileType htmldjango setlocal foldmethod=indent
    au BufRead *.py setlocal foldmethod=indent
    au BufNewFile *.py setlocal foldmethod=indent
augroup END

" Django {{{2
augroup DJANGO
    au!
    au FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" Laravel Blade template {{{2
augroup Blade
    au!
    au BufRead *.blade.php setlocal shiftwidth=2 tabstop=2 softtabstop=2 ft=html
    au BufNewFile *.blade.php setlocal shiftwidth=2 tabstop=2 softtabstop=2 ft=html
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
    au FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
    au FileType javascript.jsx set formatprg=prettier\ --single-quote\ --trailing-comma\ all\ --stdin
    au BufRead *.js setlocal shiftwidth=2 tabstop=2 softtabstop=2
    au BufNewFile *.js setlocal shiftwidth=2 tabstop=2 softtabstop=2
    au BufWritePre *.js :normal mqgggqG'q
augroup END

" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction

" TeX {{{2
augroup TeX
    au!
    au BufRead *.tex setlocal shiftwidth=2 tabstop=2 softtabstop=2
    au BufNewFile *.tex setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" All files {{{2
augroup ApplyAll
    au!
    au BufRead * setlocal breakindent breakindentopt=shift:2
    au BufNewFile * setlocal breakindent breakindentopt=shift:2
augroup END

" Set colors {{{1

set t_Co=256
"set background=light
set background=dark
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"colorscheme solarized
"colorscheme jellybeans
"colorscheme distinguished
colorscheme gruvbox
"colorscheme thornbird
"colorscheme railscasts
"hi String ctermfg=002
hi Normal ctermbg=NONE
"hi nonText ctermbg=NONE

"hi StatusLine ctermbg=014 ctermfg=015 cterm=bold
"hi TabLineFill ctermbg=008 ctermfg=000 cterm=bold
"hi TabLineSel ctermbg=000 ctermfg=255 cterm=bold
"hi TabLine ctermbg=008 ctermfg=255 cterm=bold
hi LineNr ctermbg=239 ctermfg=249
"hi MatchParen cterm=bold ctermfg=black ctermbg=254
"hi HtmlTagName ctermfg=003 cterm=none

syn match Braces display '[{}()\[\]]'
"hi Braces ctermfg=black

"hi javaScriptRegexpString ctermfg=015
" vimwiki

" Finish configurations! {{{1

filetype indent plugin on
