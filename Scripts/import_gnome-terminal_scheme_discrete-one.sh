#!/usr/bin/env bash

# ====================CONFIG THIS =============================== #
COLOR_01="#121212"             # HOST
COLOR_02="#FF005F"             # SYNTAX_STRING
COLOR_03="#5FD700"             # COMMAND
COLOR_04="#FFAF00"             # COMMAND_COLOR2
COLOR_05="#0087D7"             # PATH
COLOR_06="#8700D7"             # SYNTAX_VAR
COLOR_07="#00D7D7"             # PROMP
COLOR_08="#BCBCBC"             #

COLOR_09="#767676"             #
COLOR_10="#FF00AF"             # COMMAND_ERROR
COLOR_11="#87FF00"             # EXEC
COLOR_12="#FFD75F"             #
COLOR_13="#5FAFFF"             # FOLDER
COLOR_14="#AF5fff"             #
COLOR_15="#5fffff"             #
COLOR_16="#FFFFFF"             #

BACKGROUND_COLOR="$COLOR_01"   # Background Color
FOREGROUND_COLOR="$COLOR_08"   # Text
BOLD_COLOR="$COLOR_16"         # Bold
CURSOR_COLOR="$COLOR_16"       # Cursor
PROFILE_NAME="Discrete One"
# =============================================================== #







# =============================================================== #
# | Apply Colors
# ===============================================================|#
function gogh_colors () {
    echo ""
    echo -e "\033[0;30m█████\\033[0m\033[0;31m█████\\033[0m\033[0;32m█████\\033[0m\033[0;33m█████\\033[0m\033[0;34m█████\\033[0m\033[0;35m█████\\033[0m\033[0;36m█████\\033[0m\033[0;37m█████\\033[0m"
    echo -e "\033[0m\033[1;30m█████\\033[0m\033[1;31m█████\\033[0m\033[1;32m█████\\033[0m\033[1;33m█████\\033[0m\033[1;34m█████\\033[0m\033[1;35m█████\\033[0m\033[1;36m█████\\033[0m\033[1;37m█████\\033[0m"
    echo ""
}

function curlsource() {
    f=$(mktemp -t curlsource)
    curl -o "$f" -s -L "$1"
    source "$f"
    rm -f "$f"
}

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT_PATH="$(dirname "$SCRIPT_PATH")"

if [ -e $PARENT_PATH"/apply-colors.sh" ]
then
gogh_colors
source $PARENT_PATH"/apply-colors.sh"

else
gogh_colors
    if [ $(uname) = "Darwin" ]; then
        # OSX ships with curl and ancient bash
        # Note: here, sourcing directly from curl does not work
        curlsource https://raw.githubusercontent.com/Mayccoll/Gogh/master/apply-colors.sh
    else
        # Linux ships with wget
        source <(wget -O - https://raw.githubusercontent.com/Mayccoll/Gogh/master/apply-colors.sh)
    fi
fi
