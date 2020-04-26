" Colorschemes
"
  Plug 'dracula/vim', { 'as': 'dracula' }
  "Plug 'arcticicestudio/nord-vim'

" Syntax
"
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-liquid'

  " Stylesheets
  Plug 'hail2u/vim-css3-syntax'
  Plug 'cakebaker/scss-syntax.vim'
  "Plug 'groenewege/vim-less'

" Linting
"
  " Asynchronous Lint Engine
  Plug 'w0rp/ale'

  " Alternative great linter
  "Plug 'vim-syntastic/syntastic'

" Autocompletion
"
  " Deoplete
  Plug 'Shougo/deoplete.nvim'
    "Plug 'tweekmonster/deoplete-clang2'
    "Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

    " PHP Completion Daemon
    Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

  " HTML closing tag completion
  Plug 'alvan/vim-closetag'

" Tools
"
  " Fuzzy search
  "Plug 'junegunn/fzf'

  " File browser
  Plug 'scrooloose/nerdtree'

  " Code commenting
  Plug 'scrooloose/nerdcommenter'

  " Code tags browser
  Plug 'majutsushi/tagbar'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  "Plug 'Xuyuanp/nerdtree-git-plugin'

  " Display vertical indetation level lines
  "Plug 'Yggdroot/indentLine'

  " Close buffer leaving split or window
  Plug 'qpkorr/vim-bufkill'

  " Status line replacement
  "Plug 'itchyny/lightline.vim'

  " Emmet html tags abbreviations
  "Plug 'mattn/emmet-vim'

  " Sublime text-like multiple cursors
  "Plug 'terryma/vim-multiple-cursors'
