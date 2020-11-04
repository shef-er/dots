#!/bin/bash
#
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.
 
for fgbg in 38 48 ; do #Foreground/Background
  for color in {0..256} ; do #Colors

    #Display the color
    printf "\e[%s;5;%sm %3s \e[0m" "$fgbg" "$color" "$color"

    #Display 8 colors per lines for first 16 colors
    if [ $((($color + 1) % 8)) -eq 0 ] && [ $color -lt 16 ] ; then
      echo #New line
    fi

    #Display 6 colors per lines for colors greater than 16
    if [ $((($color + 3) % 6)) -eq 0 ] && [ $color -gt 16 ] ; then
      echo #New line
    fi

    if [ $color -eq 15 ] || [ $color -eq 231 ] ; then
      echo #New line
    fi

  done
  echo #New line
done

exit 0

