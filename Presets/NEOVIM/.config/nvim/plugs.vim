"---------------------------------------
"   Plugs
"---------------------------------------

" Plug automatic installation
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
  endif

" Specify a directory for plugins
  call plug#begin('~/.local/share/nvim/plugged')


  " Syntax
  "
    Plug 'sheerun/vim-polyglot'

    " WebDev
    "Plug 'tpope/vim-liquid'
    "Plug 'hail2u/vim-css3-syntax'
    "Plug 'cakebaker/scss-syntax.vim'
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
    Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

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
    "Plug 'xuyuanp/nerdtree-git-plugin'

    " Display vertical indetation level lines
    "Plug 'yggdroot/indentline'

    " Close buffer leaving split or window
    Plug 'qpkorr/vim-bufkill'

    " Status line replacement
    "Plug 'itchyny/lightline.vim'

    " Emmet html tags abbreviations
    "Plug 'mattn/emmet-vim'

    " Sublime text-like multiple cursors
    "Plug 'terryma/vim-multiple-cursors'


" Initialize plugin system
  call plug#end()


"---------------------------------------
"   Plugs settings
"---------------------------------------

" Vim-Polyglot
"
  "let g:polyglot_disabled = []


"
" scrooloose/nerdtree
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
  autocmd VimEnter *
        \ if argc() == 1
        \ && isdirectory(argv()[0])
        \ && !exists("s:std_in")
        \ | exe 'NERDTree' argv()[0]
        \ | wincmd p | ene | endif

  "
  " xuyuanp/nerdtree-git-plugin
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


"
" majutsushi/agbar (need: 'exuberant-ctags' package)
"
  nnoremap <F6> :TagbarToggle<CR>


"
" airblade/vim-gitgutter
"
  let g:gitgutter_sign_added = '+'
  let g:gitgutter_sign_modified = '•'
  let g:gitgutter_sign_removed = '-'

  let g:gitgutter_max_signs = 9999


"
" shougo/deoplete.nvim
"
  let g:deoplete#enable_at_startup = 0
  autocmd InsertEnter * call deoplete#enable()

  call deoplete#custom#option('ignore_sources', { 
        \ '_': ['around', 'buffer']
  \ })

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


"
" alvan/vim-closetag
"
  " filenames like *.xml, *.html, *.xhtml, ...
  " These are the file extensions where this plugin is enabled.
  "
  let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

  " filetypes like xml, html, xhtml, ...
  " These are the file types where this plugin is enabled.
  "
  let g:closetag_filetypes = 'html,xhtml,phtml'

  " filetypes like xml, xhtml, ...
  " This will make the list of non-closing tags self-closing in the specified files.
  "
  let g:closetag_xhtml_filetypes = 'xhtml,jsx'

  " integer value [0|1]
  " This will make the list of non-closing tags case-sensitive
  " (e.g. `<Link>` will be closed while `<link>` won't.)
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


"
" itchyny/lightline
"
  "set noshowmode
  "let g:lightline = {
      "\ 'colorscheme': 'nord',
      "\ }

