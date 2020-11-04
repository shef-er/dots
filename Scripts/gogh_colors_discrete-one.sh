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
SCRIPT_PATH="${SCRIPT_PATH:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
PARENT_PATH="$(dirname "${SCRIPT_PATH}")"

# Allow developer to change url to forked url for easier testing
# IMPORTANT: Make sure you export this variable if your main shell is not bash
BASE_URL=${BASE_URL:-"https://raw.githubusercontent.com/Mayccoll/Gogh/master"}


gogh_colors
if [[ -e "${PARENT_PATH}/apply-colors.sh" ]]; then
  bash "${PARENT_PATH}/apply-colors.sh"
else
  bash -c "$(wget -qO- "${BASE_URL}/apply-colors.sh")"
fi

