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
Plug 'vim-scripts/CSApprox'

"" Visual Themes
Plug 'rakr/vim-one'

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
"*****************************************************************************

call plug#end()

let g:session_autosave = 'no'
let g:session_autoload = 'no'