" general
set fenc=utf-8
set autoread
set hidden
set showcmd

" appearance
set list
set listchars=tab:-→,trail:･,extends:»,precedes:«,nbsp:･
highlight FullWidthSpace ctermbg=white
match FullWidthSpace /　/
set number
set nowrap
set cursorline
set virtualedit=onemore
set smartindent
set showmatch
set laststatus=2
set wildmode=longest,full
syntax enable

" tab
set expandtab
set tabstop=2
set shiftwidth=2

" search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" misc
set viminfo=
let g:netrw_dirhistmax=0
