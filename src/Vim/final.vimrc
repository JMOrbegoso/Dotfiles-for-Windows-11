"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************

"" Required:
call plug#begin(expand('~/vimfiles/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************

"" Visual interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/CSApprox'

"" Visual Themes
Plug 'morhetz/gruvbox'

"" Start Page
Plug 'mhinz/vim-startify'

"" Files
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-scripts/grep.vim'
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

"" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

"" Write assistants
Plug 'Yggdroot/indentLine'
Plug 'Raimondi/delimitMate'
Plug 'RRethy/vim-illuminate'
Plug 'ntpeters/vim-better-whitespace'
Plug 'preservim/nerdcommenter'

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

"*****************************************************************************
"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

"" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"

set noswapfile " Disable swap files
set nobackup " Disable backups
set nowritebackup " Disable backups

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to <spacebar>
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

"" Start Page
let g:startify_bookmarks = [
          \ { 'v': '~/.vimrc' },
          \ ]

let g:startify_lists = [
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
          \ { 'type': 'files',     'header': ['   Most recently used files'] },
          \ { 'type': 'dir',       'header': ['   Most recently used files from '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions'] },
          \ { 'type': 'commands',  'header': ['   Commands'] },
          \ ]

"" Session management
let g:session_directory = "~/vimfiles/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************

syntax on

set ruler
set number " Show row numbers
set rnu " Show relative numbers on rows
set numberwidth=1 " Size of row numbers

let no_buffers_menu=1

set mouse=a " Enables the mouse usage
set mousemodel=popup

set cursorline
set guioptions=egmrti
set gfn=Monospace\ 10

set t_Co=256

if (has("termguicolors"))
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

"" IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

"" Search mappings: These will make it so that going to the next one in a
"" Search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" Visual theme
let g:light_theme = 1

if (g:light_theme)
  set background=light
  let g:gruvbox_contrast_light='hard'
  colorscheme gruvbox
else
  set background=dark
  let g:gruvbox_contrast_dark='hard'
  colorscheme gruvbox
endif

"" Vim-Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  " no powerline symbols
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.dirty='⚡'
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  endif

"*****************************************************************************
"" Abbreviations
"*****************************************************************************

"" No one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

let g:NERDTreeIgnore = [
  \'\.rbc$',
  \'\~$',
  \'\.pyc$',
  \'\.db$',
  \'\.sqlite$',
  \'__pycache__',
  \'^node_modules$',
  \'^bin$',
  \'^obj$',
  \'^release$',
  \'^debug$',
  \]

let g:NERDTreeSortOrder = [
  \'^__\.py$',
  \'\/$',
  \'*',
  \'\.swp$',
  \'\.bak$',
  \'\~$',
  \]

"" Grep.vim
nnoremap <silent> <Leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

"" Fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

"" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

"" Ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

"*****************************************************************************
"" Commands
"*****************************************************************************

"" Remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

"*****************************************************************************
"" Functions
"*****************************************************************************

if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************

"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" Txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" Make/CMake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Open start page
noremap <silent> <Leader><Home> :Startify<CR>

"" Undo
nmap <C-z> :undo<CR>
imap <C-z> <Esc>:undo<CR>a

"" Redo
nmap <C-y> :redo<CR>
imap <C-y> <Esc>:redo<CR>a

"" Disable vim's default undo and redo
map u <nop>
map <C-r> <nop>

"" Disable process suspension on Visual mode
vmap <C-z> <nop>

"" Save current buffer
nnoremap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

"" Save all open buffers
nnoremap <Leader>s :wa<CR>

"" Select all the buffer content
noremap <C-a> ggVG<CR>

"" Open split windows
noremap <silent> <Leader>sh :<C-u>split<CR>
noremap <silent> <Leader>sv :<C-u>vsplit<CR>

"" Switch splitted windows
noremap <up> <C-w>k
noremap <down> <C-w>j
noremap <left> <C-w>h
noremap <right> <C-w>l

"" Resize split buffers
nnoremap <silent> <Leader>+ :vertical resize +3<CR>
nnoremap <silent> <Leader>- :vertical resize -3<CR>
nnoremap <silent> + :resize +3<CR>
nnoremap <silent> - :resize -3<CR>

"" Session management
nnoremap <Leader>so :OpenSession<Space>
nnoremap <Leader>ss :SaveSession<Space>
nnoremap <Leader>sd :DeleteSession<CR>
nnoremap <Leader>sc :CloseSession<CR>

"" Open new buffer
noremap <silent> <Leader>t :enew<CR>

"" Close current buffer
noremap <silent> <Leader>w :bd<CR>

"" Buffer navigation
noremap <silent> <Leader><left> :bp<CR>
noremap <silent> <Leader><right> :bn<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

"" Set working directory
nnoremap <Leader>. :lcd %:p:h<CR>

"" Recovery commands from history through FZF
nmap <Leader>y :History:<CR>

"" Nerdcommenter
let g:NERDCreateDefaultMappings = 0
map <Leader>cc <Plug>NERDCommenterToggle

"" NERDTree
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

"" FZF
nnoremap <silent> <Leader>fz :FZF -m<CR>

"" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

"" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Cut/Paste
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Clean search (highlight)
nnoremap <silent> <Leader><space> :noh<cr>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"*****************************************************************************
"" Custom configs
"*****************************************************************************

"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("~/vimfiles/local_init.vim"))
  source ~/vimfiles/local_init.vim
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************
