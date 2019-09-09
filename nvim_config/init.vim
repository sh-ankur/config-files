" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'

function! BuildMarkdownComposer(info)
    if a:info.status != 'unchanged' || a:info.force
        !cargo build --release
        UpdateRemotePlugins
    endif
endfunction

call plug#begin('~/.vim/plugged')

" Custom Plugins
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '~/my-prototype-plugin'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildMarkdownComposer'), 'for': 'markdown' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'scrooloose/nerdcommenter'
Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp'] }
Plug 'zchee/deoplete-jedi', { 'for': ['python'] }
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'shankur90/vim-license'
Plug 'vim-airline/vim-airline'
Plug 'chrisbra/csv.vim'
Plug 'miyakogi/conoline.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'nvie/vim-flake8'
Plug 'Yggdroot/indentLine'

" Themes
Plug 'flrnprz/candid.vim'

" Enable deoplete completion
let g:deoplete#enable_at_startup = 1

" NerdTreeToggle
map <C-n> :NERDTreeToggle<CR>

" Initialize plugin system
call plug#end()

" filetype plugin for nerdcommenter
filetype plugin on

" syntax highlighting
syntax on

" Set VIM parameters
set number
set ruler
set conceallevel=0
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set showmatch
set showtabline=1
set laststatus=1
set cursorline
set fo+=t
set laststatus=2
set t_Co=256

let base16colorspace=256
let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments = 1

let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦']

" Show status bar for AsyncRun
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

set termguicolors
set background=dark
colorscheme candid

" let g:airline_theme = 'candid'

" deoplete-clang settings
if has('macunix')
  let g:deoplete#sources#clang#clang_header = '/usr/local/Cellar/llvm/8.0.0/include'
  let g:deoplete#sources#clang#libclang_path = '/usr/local/Cellar/llvm/8.0.0/lib/libclang.dylib'
else
    let g:deoplete#sources#clang#clang_header = '/usr/include/clang/'
    let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
endif

" Disable the scratch preview
let g:SuperTabClosePreviewOnPopupClose = 1
set completeopt-=preview

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠ "
let g:syntastic_check_on_open = 1
let g:syntastic_python_pyflakes_exe = 'python3 -m pyflakes'
let g:syntastic_c_checkers=['gcc']
let g:syntastic_cpp_checkers=['clang_check']
let g:syntastic_h_checkers=['gcc']
let g:syntastic_hpp_checkers=['clang_check']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_clang_check_config_file = ".clang_check"

" Configure python path
" Create anaconda environment and install flake8 and pylint
if has('macunix')
    let g:syntastic_python_python_exec = '/usr/local/anaconda3/bin/python3'
    let g:python_host_prog =  '/usr/local/bin/python2'
    let g:python3_host_prog =  '/usr/local/anaconda3/bin/python3'
else
    let g:syntastic_python_python_exec = '/usr/bin/python3'
    let g:python_host_prog =  '/usr/bin/python2'
    let g:python3_host_prog =  '/usr/bin/python3'
endif

" NerdCommenter
"" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '//','right': '' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Vim License
let g:licenses_authors_name = 'Ankur Sharma'
let g:licenses_organizations_name = 'ChainifyDB GmbH'
let g:licenses_copyright_holders_name = 'Ankur Sharma (ankur.sharma@bigdata.uni-saarland.de)'

" Toggle quickfix window by F1
noremap <F2> :call asyncrun#quickfix_toggle(8)<cr>
noremap <F8> :TagbarToggle<cr>

" Config NerdTree for git
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
