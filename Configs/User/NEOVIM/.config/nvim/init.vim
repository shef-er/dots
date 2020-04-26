" ~/.config/nvim/init.vim

""""""""""""""""
" NVIM Diffs
"
" Note: these defaults can be disabled with the '-u' command line argument.
" Filetype-related plugins and scripts are enabled by default
" 'autoindent' is set by default
" 'autoread' is set by default
" 'backspace' defaults to 'indent,eol,start'
" 'complete' doesn't include 'i'
" 'display' defaults to 'lastline'
" 'encoding' defaults to 'utf-8'
" 'formatoptions' defaults to 'tcqj'
" 'history' defaults to 10000 (the maximum)
" 'hlsearch' is set by default
" 'incsearch' is set by default
" 'langnoremap' is set by default
" 'laststatus' defaults to 2 (statusline is always shown)
" 'listchars' defaults to 'tab:> ,trail:-,nbsp:+'
" 'mouse' defaults to 'a'
" 'nocompatible' is always set
" 'nrformats' defaults to 'bin,hex'
" 'sessionoptions' doesn't include 'options'
" 'smarttab' is set by default
" 'tabpagemax' defaults to 50
" 'tags' defaults to './tags;,tags'
" 'ttyfast' is always set
" 'viminfo' includes '!'
" 'wildmenu' is set by default
""""""""""""""""


"---------------------------------------
"   Plugins
"---------------------------------------
" Plug automatic installation
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
  endif

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
  call plug#begin('~/.local/share/nvim/plugged')

" Include plugsst
  runtime plugs.vim

" Initialize plugin system
  call plug#end()


"---------------------------------------
"   General
"---------------------------------------
" required:
  filetype plugin indent on
  syntax enable
  set synmaxcol=128
  "syntax sync minlines=256

" Colorscheme
  set termguicolors
  colorscheme default


"---------------------------------------
"   Interface
"---------------------------------------
" Character encodings considered when starting to edit an existing file
  set fileencodings=utf-8,cp1251
" Always add lf in the end of file
  set fileformat=unix

" Set completion mode
" When more than one match, list all matches and complete first match
" Then complete the next full match
  set wildmode=list:longest,full

" Ignore following files when completing file/directory names
  " Version control
  set wildignore+=.hg,.git,.svn
  " OS X
  set wildignore+=*.DS_Store
  " C/C++ object file
  set wildignore+=*.o
  " Python and ruby byte code
  set wildignore+=*.rbc,.rbx,*.scssc,*.sassc,.sass-cache,*.pyc,*.gem
  " Binary images
  set wildignore+=*.jpg,*.jpeg,*.tiff,*.bmp,*.gif,*.png,*.psd,*.pdf

" Set title of the window to filename
  set title

" Show (partial) command in the last line of the screen
  set showcmd

  " Precede each line with its line number
  set number

  " Show the line and column number of the cursor position
  "set ruler

  " Comma separated list of highlighted screen columns
  "set colorcolumn=100

" Fixes the freezes when cursorline or cursorcolumn enabled
  set lazyredraw

  "set cursorline
  "set cursorcolumn

" Minimal number of lines to scroll when cursor gets off the screen
  "set scrolljump=10

" Typewriter mode = keep current line in the center
  "set scrolloff=999

" Display invisible characters
  set list
  set listchars=tab:>\ ,trail:·,extends:»,precedes:«,nbsp:×
  "set listchars+=eol:¬

  " Characters to fill the statuslines and vertical separators
  set fillchars+=vert:\|

" Do not wrap long lines
  "set nowrap

" Don't break words when wrapping
  set linebreak
" Show ↪ at the beginning of wrapped lines
  if has("linebreak")
      let &sbr = nr2char(8618).' '
  endif

" Do smart indenting when starting a new line
  set smartindent

" Number of spaces to use for each step of (auto)indent
  set shiftwidth=2

" Use spaces instead of tab
  set expandtab

" Number of spaces that a tab counts for
  set tabstop=2

" Number of spaces that a tab counts for while performing editing operations
  set softtabstop=2

" Number of colors
  set t_Co=256

" Splitting a window will put the new window below or right of the current one
  set splitbelow
  set splitright

" Don't show the intro message starting Vim
  "set shortmess+=I

" Edit several files in the same time without having to save them
  set hidden

" Vim will change the current working directory whenever you open a file
  set acd

" No beeps, no flashes
  set noerrorbells visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=

" List of directories which will be searched when using :find, gf, etc.
" Search relative to the directory of the current file
" Search in the current directory
" Search downwards in a directory tree
  set path=.,,**


"---------------------------------------
"   Status line  ( +statusline )
"---------------------------------------
" Custom folding function
  function! FileSize()
      let bytes = getfsize(expand("%:p"))
      if bytes <= 0
          return ""
      endif
      if bytes < 1024
          return bytes . "B"
      else
          return (bytes / 1024) . "K"
      endif
  endfunction

  function! CurDir()
      return expand('%:p:~')
  endfunction

" Buffer number
  set statusline=\ %n:

" File name and modifed flag
  set statusline+=\ %t%m%r

" Move indicators to the right
  set statusline+=%=

" File type ( +autocmd feature )
  set statusline+=\ \ %Y

" File encoding and file format
  set statusline+=\ \ %{&enc}[%{&ff}]

" File size
  "set statusline+=\ \ %{FileSize()}

" Percentage through file in lines
  set statusline+=\ %3p%%

" Column and line numbers under cursor
  set statusline+=\ \ %3l:%3c

" Truncate here if line is too long
  set statusline+=\ %<


"---------------------------------------
"   Folding  ( +folding )
"---------------------------------------
  " za = toggle current fold
  " zR = open all folds
  " zM = close all folds
  " From https://github.com/sjl/dotfiles/blob/master/vim/.vimrc
  "function! MyFoldText()
  "    let line = getline(v:foldstart)
  "    let nucolwidth = &fdc + &number * &numberwidth
  "    let windowwidth = winwidth(0) - nucolwidth - 3
  "    let foldedlinecount = v:foldend - v:foldstart
  "    " expand tabs into spaces
  "    let onetab = strpart(' ', 0, &tabstop)
  "    let line = substitute(line, '\t', onetab, 'g')
  "    let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
  "    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  "    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
  "endfunction
  "set foldtext=MyFoldText()

  " Lines with equal indent form a fold
  set foldmethod=indent
  "set foldmethod=syntax
" Maximum nesting of folds
  set foldnestmax=10
" All folds are open
  set nofoldenable
" Folds with a higher level will be closed
  set foldlevel=1
" Remove the extrafills --------
  set fillchars="fold: "


"---------------------------------------
"   Search
"---------------------------------------
" Ignore case in search patterns
  "set ignorecase
" Override the 'ignorecase' if the search pattern contains upper case characters
  "set smartcase

" For regular expressions turn magic on
  set magic


"---------------------------------------
"   Environment
"---------------------------------------
" Don't create backups and swap files
  set nobackup
  "set backupdir=~/.local/share/nvim/backup

  set noswapfile
  "set directory=~/.local/share/nvim/swap
  "
  set noundofile
  "set undodir=~/.local/share/nvim/undo


" Same clipboard with the system
  set clipboard=unnamed,unnamedplus

" Remaping russian symbols
  set keymap=russian-jcukenwin
  set iminsert=0
  set imsearch=0

" Russian spellcheck with 'ё'
  set spelllang=ru_yo,en_us

  " Config autoreload
  "if has("autocmd")
  "  autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
  "endif

"---------------------------------------
"   File specific settings
"---------------------------------------
  autocmd BufNewFile *.txt setlocal wrap

  autocmd BufNewFile,BufReadPost *.md set filetype=markdown

  autocmd BufNewFile *.c 0r ~/.config/nvim/templates/template.c
  autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/template.cpp
  autocmd BufNewFile *.py 0r ~/.config/nvim/templates/template.py
  autocmd BufNewFile *.html 0r ~/.config/nvim/templates/template.html
  autocmd BufNewFile Makefile 0r ~/.config/nvim/templates/template.makefile


"---------------------------------------
"   Shortcuts
"---------------------------------------
" mappings modifer
  let mapleader = ","

" Disables suspending by <Ctrl+z>
  nnoremap <c-z> <nop>
" language switch in vim
  cmap <silent> <C-F> <C-^>
  imap <silent> <C-F> <C-^>X<Esc>a<C-H>
  nmap <silent> <C-F> a<C-^><Esc>
  vmap <silent> <C-F> <Esc>a<C-^><Esc>gv

" stop using arrows in vim
  "nnoremap <Up> :echomsg "use k"<CR>
  "nnoremap <Down> :echomsg "use j"<CR>
  "nnoremap <Left> :echomsg "use h"<CR>
  "nnoremap <Right> :echomsg "use l"<CR>

" open a terminal in current dir
  nnoremap <F4> :silent !x-terminal-emulator &<CR>

" <Esc><Esc>
" Clear the search highlight in Normal mode
  nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" ,ts
" Fix trailing white space
  nnoremap <leader>ts :<C-u>%s/\s\+$//e<CR>

" ,br
" Delete all buffers except off current
  function! CloseAllBuffersButCurrent()
    let curr = bufnr("%")
    let last = bufnr("$")

    :NERDTreeClose
    if curr > 1    | silent! execute "1,".(curr-1)."bd"     | endif
    if curr < last | silent! execute (curr+1).",".last."bd" | endif
  endfunction
  nnoremap <Leader>br :call CloseAllBuffersButCurrent()<CR>

" ,bl
" Show buffers
  nnoremap <Leader>bl :<C-u>ls<cr>:b

" ,bp
" Go to prev buffer
  nnoremap <Leader>bp :<C-u>bp<cr>

" ,bn
" Go to next buffer
  nnoremap <Leader>bn :<C-u>bn<cr>

" ,bd
" Delete current buffer saving split
  nnoremap <Leader>bd :<C-u>bp\|bd #<cr>

" ,w
" Jump to next split
  nnoremap <Leader>w <C-w>w

" Y
" copy from cursor position to the end of line
  nnoremap Y y$

" Bind :W to :w
  command! W w
" Bind :Q to :q
  command! Q q

" Save file with root permissions
  command! WW exec 'w !sudo tee % > /dev/null' | e!

" Jump to begin/end of line in command mode
  cnoremap <c-e> <end>
  inoremap <c-e> <c-o>$
  cnoremap <c-a> <home>
  inoremap <c-a> <c-o>^

" Ctrl+s
  noremap <C-s> <esc>:w<CR>
  inoremap <C-s> <esc>:w<CR>

" Ctrl+ы
  noremap <C-ы> <esc>:w<CR>
  inoremap <C-ы> <esc>:w<CR>

" ,<Tab>
" Switch tabs with <Tab>
  nnoremap <Leader><Tab> gt
  nnoremap <Leader><S-Tab> gT

" ,v
" Open vim config
  nnoremap <Leader>v <esc>:e ~/.config/nvim/init.vim<CR>

" Show syntax highlighting groups for word under cursor
  nmap <C-S-p> :call <SID>SynStack()<CR>
  function! <SID>SynStack()
    if !exists("*synstack")
      return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunc

" Tab navigation like Firefox.
  nnoremap <C-S-tab> :tabprevious<CR>
  nnoremap <C-tab>   :tabnext<CR>
  nnoremap <C-t>     :tabnew<CR>
  inoremap <C-S-tab> <Esc>:tabprevious<CR>i
  inoremap <C-tab>   <Esc>:tabnext<CR>i
  inoremap <C-t>     <Esc>:tabnew<CR>


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
