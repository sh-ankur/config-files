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

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

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

" SpaceGray theme
Plug 'ajh17/Spacegray.vim'

" Themes for vim
Plug 'nightsense/nemo'
Plug 'marcopaganini/termschool-vim-theme'

" Syntastic
Plug 'vim-syntastic/syntastic'

" Git
Plug 'tpope/vim-fugitive'

Plug 'wesQ3/vim-windowswap'
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
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'

" Airline Plug
Plug 'vim-airline/vim-airline'

" CSV Plug
Plug 'chrisbra/csv.vim'

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

" deoplete tab-complete
" inoremap <silent><expr> <Tab>
"     \ pumvisible() ? "\<C-n>" : deoplete#manual_complete()

set background=light
colorscheme termschool
" colorscheme spacegray
" colorscheme nemo-light

" deoplete settings
let g:deoplete#sources#clang#clang_header = '/usr/local/Cellar/llvm/5.0.0/lib/clang/'
let g:deoplete#sources#clang#libclang_path = '/usr/local/Cellar/llvm/5.0.0/lib/libclang.dylib'

" Disable the scratch preview
" let g:SuperTabClosePreviewOnPopupClose = 1
set completeopt-=preview
