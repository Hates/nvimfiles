call plug#begin('~/.vim/plugged')

Plug 'neomake/neomake'
let g:neomake_javascript_enabled_makers = ['standard']
autocmd! BufWritePost * Neomake

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'Yggdroot/indentLine'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <c-p> :FZF<cr>
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

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
let g:NERDTreeMouseMode=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <Leader>r :NERDTreeToggle<CR>
nnoremap <Leader>t :NERDTreeFind<CR>

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'

Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'eruby'] }
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_cache_dir = '~/.tags_cache'

Plug 'majutsushi/tagbar'
nmap <F2> :TagbarToggle<CR>
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'f:functions',
        \ 'functions:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records'
    \ ]
    \ }

"" Theme plugins.
Plug 'itchyny/lightline.vim'
Plug 'dracula/vim'

call plug#end()

" Performance improvments
if has("mac")
  set nocursorline

  if exists("+relativenumber")
    set norelativenumber
  endif

  set foldlevel=0
  set foldmethod=manual
endif

" Use lazy redraw
set lazyredraw

" Set mouse mode
set mouse=a

" Make backspace work like other apps
set backspace=2

" Set filetype specific indentation
filetype plugin indent on

" Statusline settings
set noshowmode showcmd cmdheight=2

" Enable the undofile
set undofile

" Searching
set ignorecase "searches are case insensitive...
set smartcase  "unless they contain one capital letter

" No backups or swap
set nobackup noswapfile

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

" Grepping
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!{.git,.bundle,log}/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
set grepprg=rg\ --vimgrep

" Display tabs and trailing spaces
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
augroup golang
  autocmd BufRead *.go set nolist
augroup END

set showbreak=↪

"Dont continue comments when pushing o/O
set formatoptions-=o 

" Vertical/horizontal scroll off settings
set scrolloff=6
set sidescrolloff=7
set sidescroll=1

" Turn on syntax highlighting
syntax enable
syntax sync minlines=250

" Hide buffers when not displayed
set hidden

" \ is the leader character
let mapleader = "\\"

" Theme options
set background=dark
colorscheme dracula
highlight Normal ctermbg=NONE
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
