# ~/.zshrc

##
## Hotkeys:
##

# Ctrl + Shift Switching between keyboard layouts

## Moving cursor:
# Ctrl + a   Go to the beginning of the line (Home)
# Ctrl + e   Go to the End of the line (End)
# Ctrl + p   Previous command (Up arrow)
# Ctrl + n   Next command (Down arrow)
# Ctrl + f   Forward one character
# Ctrl + b   Backward one character
#  Alt + b   Back (left) one word
#  Alt + f   Forward (right) one word

## Editing:
# Ctrl + l   Clear the Screen, similar to the clear command.
#
#  Alt + Del Delete the Word before the cursor. ?
#  Alt + d   Delete the Word after the cursor.
# Ctrl + d   Delete character under the cursor.
# Ctrl + h   Delete character before the cursor (Backspace)
#
# Ctrl + w   Cut the Word before the cursor to the clipboard.
# Ctrl + k   Cut the Line after the cursor to the clipboard.
# Ctrl + u   Cut/delete the Line before the cursor to the clipboard.
#
#  Alt + t   Swap current word with previous.
# Ctrl + t   Swap the last two characters before the cursor (typo).
#  Esc + t   Swap the last two words before the cursor.
#
# Ctrl + y   Paste the last thing to be cut (yank)
#  Alt + u   UPPER capitalize every character from the cursor to the end of the current word.
#  Alt + l   Lower the case of every character from the cursor to the end of the current word.
#  Alt + c   Capitalize the character under the cursor and move to the end of the word.
#  Alt + r   Cancel the changes and put back the line as it was in the history (revert).
# Ctrl + _   Undo
#
# TAB        Tab completion for file/directory names

## History:
# Ctrl + r   Recall the last command including the specified character(s)
# Ctrl + p   Previous command in history (i.e. walk back through the command history)
# Ctrl + n   Next command in history (i.e. walk forward through the command history)

# Ctrl + s   Go back to the next most recent command.
#            (beware to not execute it from a terminal because this will also launch its XOFF).
# Ctrl + o   Execute the command found via Ctrl+r or Ctrl+s
# Ctrl + g   Escape from history searching mode
#       !!   Repeat last command
#     !abc   Run last command starting with abc
#   !abc:p   Print last command starting with abc
#       !$   Last argument of previous command
#  ALT + .   Last argument of previous command
#       !*   All arguments of previous command
# ^abc­^­def   Run previous command, replacing abc with def

## Process control:
# Ctrl + c   Interrupt/Kill whatever you are running (SIGINT)
# Ctrl + l   Clear the screen
# Ctrl + s   Stop output to the screen (for long running verbose commands)
#            Then use PgUp/PgDn for navigation
# Ctrl + q   Allow output to the screen (if previously stopped using command above)
# Ctrl + d   Send an EOF marker, unless disabled by an option, this will close the current shell (EXIT)
# Ctrl + z   Send the signal SIGTSTP to the current task, which suspends it.
#            To return to it later enter fg 'process name' (foreground).

## Special keys:
# Ctrl+I = Tab
# Ctrl+J = Newline
# Ctrl+M = Enter
# Ctrl+[ = Escape
#
# Many terminals will also send control characters for keys in the digit row:
# Ctrl+2 → ^@
# Ctrl+3 → ^[ = Escape
# Ctrl+4 → ^\
# Ctrl+5 → ^]
# Ctrl+6 → ^^
# Ctrl+7 → ^_ = Undo
# Ctrl+8 → ^? = Backward-delete-char
#
# Ctrl + v   tells the terminal to not interpret the following character
#---------------------------------------


#---------------------------------------
# ZSH Configuration
#---------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=10000

setopt appendhistory autocd extendedglob completealiases histignoredups histignorespace
unsetopt beep

setopt HIST_IGNORE_DUPS

zstyle :compinstall filename '${HOME}/.zshrc'

zstyle ':completion:*'              menu select
zstyle ':completion:*'              rehash true

zstyle ':completion:*:kill:*'       force-list always
zstyle ':completion:*:*:kill:*'     menu yes select

zstyle ':completion:*:killall:*'    force-list always
zstyle ':completion:*:*:killall:*'  menu yes select

zstyle ':completion:*:processes-names' command  'ps c -u ${USER} -o command | uniq'

autoload -Uz compinit colors
_comp_options+=(globdots)
compinit
colors


#---------------------------------------
# Terminal prompt
#---------------------------------------
case `id -u` in
  0)
    PROMPT=" %F{yellow}%n@%M%f %F{cyan}%2~%f %F{red}#%f "
    ;;
  *)
    PROMPT=" %F{yellow}%n@%M%f %F{cyan}%2~%f %F{green}$%f "
    ;;
esac


#---------------------------------------
# Terminal title
#---------------------------------------
precmd () {
  print -Pn "\e]0;%n@%M %2~ %(1j,%j job%(2j|s|); ,)\a"
}


#---------------------------------------
# Keybindings
#---------------------------------------
bindkey -e

bindkey "^[[H"  beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[2~" overwrite-mode
bindkey "^[[3~" delete-char
bindkey "^[[A"  up-line-or-history
bindkey "^[[B"  down-line-or-history
bindkey "^[[D"  backward-char
bindkey "^[[C"  forward-char
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward


#---------------------------------------
# TTY coloring
#---------------------------------------
# set tty colours to match .Xresources scheme.
if [ "$TERM" = "linux" ]; then
  echo -en "\e]P0121212" #black
  echo -en "\e]P1FF005F" #dark red
  echo -en "\e]P25FD700" #dark green
  echo -en "\e]P3FFAF00" #dark yellow
  echo -en "\e]P40087D7" #dark blue
  echo -en "\e]P58700D7" #dark magenta
  echo -en "\e]P600D7D7" #dark cyan
  echo -en "\e]P7BCBCBC" #light grey

  echo -en "\e]P8767676" #dark grey
  echo -en "\e]P9FF00AF" #red
  echo -en "\e]PA87FF00" #green
  echo -en "\e]PBFFD75F" #yellow
  echo -en "\e]PC5FAFFF" #blue
  echo -en "\e]PDAF5fff" #magenta
  echo -en "\e]PE5fffff" #cyan
  echo -en "\e]PFFFFFFF" #white

  clear #remove background artifacting
fi


#---------------------------------------
# Output coloring
#---------------------------------------
alias ls='ls --color=auto --group-directories-first'
alias dmesg='dmesg --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias gcc='gcc -fdiagnostics-color=auto'
alias dir='dir --color=auto'

if [ -f /usr/bin/grc ]; then
  alias irclog="grc --colour=auto irclog"
  alias log="grc --colour=auto log"
  alias netstat="grc --colour=auto netstat"
  alias ping="grc --colour=auto ping"
  alias proftpd="grc --colour=auto proftpd"
  alias traceroute="grc --colour=auto traceroute"
fi

# manpages coloring
man() {
  env \
  LESS_TERMCAP_mb=$'\e[1;34m' \
  LESS_TERMCAP_md=$'\e[1;34m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[47;30m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[4;97m' \
  man "$@"
}


#---------------------------------------
# Aliases
#---------------------------------------
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi


#---------------------------------------
# Functions
#---------------------------------------
if [ -f ~/.zsh_funcs ]; then
    source ~/.zsh_funcs
fi

ttyctl -f

