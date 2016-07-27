call plug#begin('~/.vim/plugged')

Plug 'rking/ag.vim'

Plug 'tpope/vim-fugitive'

Plug 'neomake/neomake'
let g:neomake_javascript_enabled_makers = ['standard']
autocmd! BufWritePost * Neomake

Plug 'Yggdroot/indentLine'

Plug 'ludovicchabant/vim-gutentags'
let gutentags_tagfile = '.tags'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>

Plug 'jlanzarotta/bufexplorer'
map <C-b> :BufExplorer<CR>

Plug 'simnalamburt/vim-mundo'
inoremap <silent> <F1> <ESC>:MundoToggle<CR>
nnoremap <silent> <F1> :MundoToggle<CR>
vnoremap <silent> <F1> <ESC>:MundoToggle<CR>

Plug 'Lokaltog/vim-easymotion'
nmap s <Plug>(easymotion-w)
nmap S <Plug>(easymotion-b)

Plug 'scrooloose/nerdcommenter'

Plug 'jeetsukumaran/vim-filebeagle'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
let g:NERDTreeMouseMode=3
nnoremap <Leader>r :NERDTreeToggle<CR>

Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'

Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'eruby'] }
Plug 'tpope/vim-haml', { 'for': 'haml' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
let g:rustfmt_autosave = 1

Plug 'majutsushi/tagbar'
nmap <F2> :TagbarToggle<CR>

" Theme plugins.
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim'
Plug 'owickstrom/vim-colors-paramount'

call plug#end()

" Use lazy redraw
set lazyredraw

" Make backspace work like other apps
set backspace=2

" Set filetype specific indentation
filetype plugin indent on

" Statusline settings
set noshowmode showcmd cmdheight=2

" Store lots of :cmdline history
set undoreload=10000
set undofile

" Searching
set ignorecase "searches are case insensitive...
set smartcase  "unless they contain one capital letter

" No backups or swap
set backup noswapfile

set undodir=~/.vim/tmp/undo// " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap// " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" Indent settings
set shiftwidth=2
set softtabstop=2
set expandtab

" Folding settings
set nofoldenable

" Set line numbers
set number

" Ignore files
set wildmode=list:longest
set wildignore+=.hg,.git,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.woff,*.ttf,*.svg,*.eot
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest
set wildignore+=*.spl
set wildignore+=*.sw?
set wildignore+=*.DS_Store
set wildignore+=*.orig
set wildignore+=*/tmp/*

" Display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅,extends:#
set showbreak=↪

set formatoptions-=o "dont continue comments when pushing o/O

" Vertical/horizontal scroll off settings
set scrolloff=6
set sidescrolloff=7
set sidescroll=1

" Turn on syntax highlighting
syntax enable
syntax sync minlines=250

" Highlight search results
set hlsearch

" Hide buffers when not displayed
set hidden

" \ is the leader character
let mapleader = "\\"

" Theme options
set background=dark
colorscheme dracula
let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night',
      \ 'component_function': {
      \   'filename': 'LightLineFilename'
      \ }
      \ }
function! LightLineFilename()
  return expand('%')
endfunction
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Set the tag file search order
set tags=./tags

" Set region to British English
set spelllang=en_gb

" Set the timeout to be low
set timeout ttimeoutlen=50

" Support for mobile templates
autocmd BufNewFile,BufRead *.mobile.erb let b:eruby_subtype='html'
autocmd BufNewFile,BufRead *.mobile.erb set filetype=eruby

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
" }}}

" Hide search highlighting
map <Leader>h :nohl <CR>

" Opens an edit command with the path of the currently edited file filled in Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Function key mappings

" F4 - Toggle paste
nnoremap <F4> :set paste!<Bar>set paste?<CR>

" F5 - Toggle wrapping
set linebreak "wrap lines at convenient points
set nowrap " Set no wrap and bind.
nnoremap <F5> :set nowrap! <CR>

" F6 - Replace whitespace.
nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" F7 - Unused
" F8 - Unused

" F9 - Ruby Hash syntax change
map <F9> :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

" F10 - Findhighlighting
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" F11 - Unused
" F12 - Unused

" Normal key mappings

" Map ENTER to save
nmap <CR> :write<CR>

" Do something about indenting
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv

" Use arrow keys to move lines
nnoremap <Down> :m+<CR>==
nnoremap <Up> :m-2<CR>==

"map Q to something useful
noremap Q gq

"make Y consistent with C and D. Copy to end of line.
nnoremap Y y$

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" Ctrl-J/K deletes blank line below/above, and Ctrl-j/k inserts.
nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>
