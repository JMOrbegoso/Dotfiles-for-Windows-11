"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************

"" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************

"" Visual interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/CSApprox'

"" Visual Themes
Plug 'rakr/vim-one'

"" Start Page
Plug 'mhinz/vim-startify'

"" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse

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

"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"" Write assistants
Plug 'Yggdroot/indentLine'
Plug 'Raimondi/delimitMate'
Plug 'RRethy/vim-illuminate'
Plug 'ntpeters/vim-better-whitespace'
Plug 'preservim/nerdcommenter'

"" Code completion
let g:coc_node_path = '$HOME/.volta/bin/node'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" Code Linter
Plug 'dense-analysis/ale'

"" Templates
Plug 'pgilad/vim-skeletons'

"" Terminal
Plug 'caenrique/nvim-toggle-terminal'

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

"" Go
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}

"" HTML
Plug 'hail2u/vim-css3-syntax'
Plug 'gko/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'

"" JavaScript
Plug 'jelera/vim-javascript-syntax'

"" TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'

"" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

"*****************************************************************************
"*****************************************************************************

call plug#end()

let g:session_autosave = 'no'
let g:session_autoload = 'no'