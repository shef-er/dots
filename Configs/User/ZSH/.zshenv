# ~/.zshenv
# vim: set syntax=zsh

#---------------------------------------
# PATH
#---------------------------------------

if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# nodejs binaries
if [ -d "$HOME/.local/lib/node_modules/bin" ] ; then
  PATH="$HOME/.local/lib/node_modules/bin:$PATH"
fi

# ruby gems
if [ -d "$HOME/.gem/ruby/2.5.0/bin" ] ; then
  PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"
fi

export PATH


#---------------------------------------
# ENV VARS
#---------------------------------------

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=less

export XDG_CONFIG_HOME=${HOME}/.config

export EDITOR=nvim

# for qt5 apps
export QT_STYLE_OVERRIDE=GTK+

# for java apps
#export JAVA_FONTS=/usr/share/fonts/TTF
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

