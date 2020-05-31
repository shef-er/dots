"---------------------------------------
"   Plugs
"---------------------------------------

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
  " IntelliSense
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}

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


"---------------------------------------
"   Plugs settings
"---------------------------------------

" Vim-Polyglot
"
  let g:polyglot_disabled = []


" NERDTree
"
  nnoremap <F5> :NERDTreeToggle<CR>

  let NERDTreeShowBookmarks = 1
  let NERDTreeShowHidden = 1
  let NERDTreeQuitOnOpen = 0

  " Disable display of the 'Bookmarks' label and 'Press ? for help' text
  let NERDTreeMinimalUI = 0

  " Use arrows instead of + ~ chars when displaying directories
  let NERDTreeDirArrows = 1
  let g:NERDTreeDirArrowExpandable = '▶'
  let g:NERDTreeDirArrowCollapsible = '▼'
  let NERDTreeAutoDeleteBuffer = 1
  let NERDTreeBookmarksFile= $HOME . '/.config/nvim/NERDTreeBookmarks'

  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

  " NERDTree git plugin
  "
    let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "~",
      \ "Staged"    : "+",
      \ "Untracked" : "*",
      \ "Renamed"   : "→",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "-",
      \ "Dirty"     : "×",
      \ "Clean"     : "ø",
      \ 'Ignored'   : "◊",
      \ "Unknown"   : "?"
      \ }
    " a heavy feature may cost much more time
    let g:NERDTreeShowIgnoredStatus = 0


" Tagbar (need: 'exuberant-ctags' package)
"
  nnoremap <F6> :TagbarToggle<CR>


" vim-gitgutter
"
  let g:gitgutter_sign_added = '•'
  let g:gitgutter_sign_modified = '•'
  let g:gitgutter_sign_removed = '•'

  let g:gitgutter_max_signs = 9999


" deoplete
"
  let g:deoplete#enable_at_startup = 1

  let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
  " For 'lvht/phpcd'
  let g:deoplete#ignore_sources.php = ['omni']

  " deoplete-clang2
    "let g:deoplete#sources#clang#executable = '/usr/lib/llvm-3.8/lib/libclang-3.8.so'

  " deoplete-tern
    "let g:tern_request_timeout = 1
    " This do disable full signature type on autocomplete
    "let g:tern_show_signature_in_pum = '0'

  " omnifuncs
    "set omnifunc=syntaxcomplete#Complete
    "augroup omnifuncs
    "  autocmd!
    "  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    "  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    "  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    "  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    "  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    "augroup end


" vim-closetag
"
  " filenames like *.xml, *.html, *.xhtml, ...
  " These are the file extensions where this plugin is enabled.
  "
  let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

  " filenames like *.xml, *.xhtml, ...
  " This will make the list of non-closing tags self-closing in the specified files.
  "
  let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

  " filetypes like xml, html, xhtml, ...
  " These are the file types where this plugin is enabled.
  "
  let g:closetag_filetypes = 'html,xhtml,phtml'

  " filetypes like xml, xhtml, ...
  " This will make the list of non-closing tags self-closing in the specified files.
  "
  let g:closetag_xhtml_filetypes = 'xhtml,jsx'

  " integer value [0|1]
  " This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
  "
  let g:closetag_emptyTags_caseSensitive = 1

  " dict
  " Disables auto-close if not in a "valid" region (based on filetype)
  "
  let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion',
      \ 'javascript.jsx': 'jsxRegion',
      \ }

  " Shortcut for closing tags, default is '>'
  "
  let g:closetag_shortcut = '>'

  " Add > at current position without closing the current tag, default is ''
  "
  let g:closetag_close_shortcut = '<leader>>'


" lightline
"
  "set noshowmode
  "let g:lightline = {
      "\ 'colorscheme': 'nord',
      "\ }


