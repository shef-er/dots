"---------------------------------------
"   Settings
"---------------------------------------
  runtime settings.vim

"---------------------------------------
"   Shortcuts
"---------------------------------------
  runtime shortcuts.vim

"---------------------------------------
"   Plugins
"---------------------------------------
" Plug automatic installation
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
  endif

" Specify a directory for plugins
  call plug#begin('~/.local/share/nvim/plugged')

" Plug configuration
  runtime plugs.vim

" Initialize plugin system
  call plug#end()

