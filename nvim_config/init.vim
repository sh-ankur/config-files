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

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' |
Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Custom Plugins
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Themes for vim
Plug 'gertjanreynaert/cobalt2-vim-theme'
Plug 'Badacadabra/vim-archery'
Plug 'hzchirs/vim-material'
Plug 'KeitaNakamura/neodark.vim'

" Syntastic
Plug 'vim-syntastic/syntastic'

" Git
Plug 'tpope/vim-fugitive'

" Tagbar
Plug 'majutsushi/tagbar'

" Plug 'wesQ3/vim-windowswap'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildMarkdownComposer'), 'for': 'markdown' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'scrooloose/nerdcommenter'
Plug 'skywind3000/asyncrun.vim'
Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp'] }
Plug 'zchee/deoplete-jedi', { 'for': ['python'] }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'nathanaelkane/vim-indent-guides'

" Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'

" Airline Plug
Plug 'vim-airline/vim-airline'

" CSV Plug
Plug 'chrisbra/csv.vim'

" Cursorline
Plug 'miyakogi/conoline.vim'

" Enable deoplete completion
let g:deoplete#enable_at_startup = 1

" NerdTreeToggle
map <C-n> :NERDTreeToggle<CR>

" Initialize plugin system
call plug#end()

" show line numbers
set number
set ruler

" syntax highlighting
syntax on

" Set VIM parameters
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set showmatch
set showtabline=2
set laststatus=2
set cursorline

" set laststatus=2
set t_Co=256

let base16colorspace=256
let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments = 1

" Use indent guide by default
let g:indent_guides_enable_on_vim_startup = 1

" Show status bar for AsyncRun
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

colorscheme neodark
let g:airline_theme='neodark'

" deoplete-clang settings
if has('macunix')
    let g:deoplete#sources#clang#clang_header = '/usr/local/Cellar/llvm/5.0.1/lib/clang/'
    let g:deoplete#sources#clang#libclang_path = '/usr/local/Cellar/llvm/5.0.1/lib/libclang.dylib'
else
    let g:deoplete#sources#clang#clang_header = '/usr/include/clang/'
    let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so.5'
endif

" Disable the scratch preview
let g:SuperTabClosePreviewOnPopupClose = 1
set completeopt-=preview

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠ "
let g:syntastic_check_on_open = 1
let g:syntastic_python_pyflakes_exe = 'python -m pyflakes'
let g:syntastic_c_checkers=['cppcheck', 'clang_check']
let g:syntastic_cpp_checkers=['cppcheck', 'clang_check']
let g:syntastic_h_checkers=['cppcheck', 'clang_check']
let g:syntastic_hpp_checkers=['cppcheck', 'clang_check']
let g:syntastic_python_checkers=['flake8']

" Configure python path
" Create anaconda environment and install flake8 and pylint
if has('macunix')
    let g:syntastic_python_python_exec = '/anaconda3/envs/deepl/bin/python'
    let g:python_host_prog =  '/anaconda3/envs/nvim2/bin/python'
    let g:python3_host_prog =  '/anaconda3/envs/deepl/bin/python'
else
    let g:syntastic_python_python_exec = '/usr/bin/python'
    let g:python_host_prog =  '/usr/bin/python2'
    let g:python3_host_prog =  '/usr/bin/python'
endif

" Toggle quickfix window by F1
noremap <F2> :call asyncrun#quickfix_toggle(8)<cr>
noremap <F8> :TagbarToggle<cr>

" Autostart nerd tree when nvim starts
autocmd vimenter * NERDTree

" Start NerdTree if nvim starts without a file name
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close nvim if all buffers are deleted
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Automatically open tagbar
" autocmd VimEnter * nested TagbarOpen

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
