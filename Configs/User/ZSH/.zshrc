#---------------------------------------
# ZSH Configuration
#---------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=10000

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# Completion
autoload -Uz compinit
_comp_options+=( globdots )
mkdir -p $HOME/.cache/zsh
compinit -d ${HOME}/.cache/zsh/zcompdump-$ZSH_VERSION

# Colors
autoload -Uz colors
colors

# VCS Info
autoload -Uz vcs_info
precmd_functions+=( vcs_info )
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )

zstyle :compinstall                     filename '${HOME}/.zshrc'

zstyle ':completion:*'                  menu select
zstyle ':completion:*'                  rehash true
zstyle ':completion:*:kill:*'           force-list always
zstyle ':completion:*:*:kill:*'         menu yes select
zstyle ':completion:*:killall:*'        force-list always
zstyle ':completion:*:*:killall:*'      menu yes select
zstyle ':completion:*:processes-names'  command  'ps c -u ${USER} -o command | uniq'

# Format the vcs_info_msg_0_
zstyle ':vcs_info:*'                    enable git
zstyle ':vcs_info:git:*'                formats ' ⎇ %b '

unsetopt beep
setopt autocd extendedglob completealiases
setopt appendhistory histignoredups histignorespace
setopt PROMPT_SUBST


#---------------------------------------
# Precommand (launches before each prompt)
#---------------------------------------
precmd () {
  #vcs_info
  #print -Pn "\e]0; %n@%M  %2~  %(1j,%j job%(2j|s|); ,)\a"
  print -Pn "\e]0;%2~ %(1j,%j job%(2j|s|); ,)\a"
}


#---------------------------------------
# Terminal prompt
#---------------------------------------
# Colors: 
#   0:black, 1:red, 2:green, 3:yellow,
#   4:blue, 5:magent, 6:cyan, 7:white
#
# %F{color} - fg color
# %K{color} - bg color
# %S        - swap text and bg colors
# %B        - bright color variant
#
# %f        - reset fg color
# %k        - reset bg color
# %s        - reset color swapping
# %b        - reset bright color
#
function custom_prompt {
  NEWLINE=$'\n'

  PROMPT_ID="%F{blue} %n@%M "
  PROMPT_PATH="%F{cyan} %2~ "
  PROMPT_VCS='%F{magent}${vcs_info_msg_0_}'

  PROMPT_LINE1="%S${PROMPT_ID}${PROMPT_PATH}${PROMPT_VCS}"

  case `id -u` in
    0)
      PROMPT_LINE2=" %F{red}#%f "
      ;;
    *)
      PROMPT_LINE2=" %F{green}→%f "
      ;;
  esac

  echo "${PROMPT_LINE1}%k%f%s${NEWLINE}${PROMPT_LINE2}%k%f%s"
}
PROMPT="$(custom_prompt)" 


#---------------------------------------
# TTY coloring
#---------------------------------------
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
  alias configure="grc --colour=auto configure"
  alias ping="grc --colour=auto ping"
  alias traceroute="grc --colour=auto traceroute"
  alias gcc="grc --colour=auto gcc"
  alias gcc="grc --colour=auto gcc"
  alias netstat="grc --colour=auto netstat"
  alias diff="grc --colour=auto diff"
  alias wdiff="grc --colour=auto wdiff"
  alias log="grc --colour=auto log"
  alias ldap="grc --colour=auto ldap"
  alias cvs="grc --colour=auto cvs"
  alias mount="grc --colour=auto mount"
  alias mtr="grc --colour=auto mtr"
  alias ps="grc --colour=auto ps"
  alias dig="grc --colour=auto dig"
  alias ifconfig="grc --colour=auto ifconfig"
  alias ls="grc --colour=auto ls"
  alias mount="grc --colour=auto mount"
  alias df="grc --colour=auto df"
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
# Input settings
#---------------------------------------
if [ -f ~/.zinput ]; then
    source ~/.zinput
fi


#---------------------------------------
# Aliases
#---------------------------------------
if [ -f ~/.zaliases ]; then
    source ~/.zaliases
fi


#---------------------------------------
# Functions
#---------------------------------------
if [ -f ~/.zfunctions ]; then
    source ~/.zfunctions
fi

ttyctl -f

