autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd FocusGained,BufEnter * silent! checktime
filetype indent on
filetype plugin on
highlight IdeographicSpace ctermbg=white
map <C-space> ?
map <space> /
match IdeographicSpace /　/
nnoremap <Esc><Esc> :nohlsearch<CR>
set autoindent
set autoread
set backspace=eol,start,indent
set cursorline
set foldcolumn=1
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set linebreak
set list
set listchars=tab:-→,trail:·,extends:»,precedes:«,nbsp:·
set matchtime=0
set noerrorbells
set nowrap
set nowrapscan
set number
set regexpengine=0
set scrolloff=7
set shiftwidth=0
set showcmd
set showmatch
set smartcase
set smartindent
set softtabstop=-1
set statusline=%F%m%h%w\ %<%=[0x%02B]\ [Ln\ %l,\ Col\ %02v]\ [%{&fileencoding!=''?&fileencoding:&encoding}]\ [%{&fileformat}]\ [%Y]
set t_vb=
set tabstop=2
set textwidth=500
set timeoutlen=500
set viminfofile=NONE
set virtualedit=onemore
set whichwrap+=<,>,h,l
set wildmenu
set wildmode=longest,full
syntax enable
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
