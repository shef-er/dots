#!/usr/bin/env bash
#
# Perform installation of dotfiles presets

set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# ----------------
# CONFIG
# ----------------
DIFF_TOOL="meld"
PRESETS_DIR="Presets"
DEST_DIR="${HOME}"


# ----------------
# FORMAT
# ----------------
dots::format::color() {
    ESC="$(echo -en '\e')"
    case "${1:-"no"}" in
        "red")      COLOR="[31m" ;;
        "green")    COLOR="[32m" ;;
        "yellow")   COLOR="[33m" ;;
        "blue")     COLOR="[34m" ;;
        "magenta")  COLOR="[35m" ;;
        "cyan")     COLOR="[36m" ;;
        *)          COLOR="[39m" ;;
    esac
    echo -n "${ESC}${COLOR}"
}


# ----------------
# LOGS
# ----------------
dots::log() {
    echo "[INFO] [$(date +'%Y-%m-%dT%H:%M:%S%z')]:" "$@" >&2
}

dots::success() {
    dots::format::color "green"
    echo "[SUCCESS] [$(date +'%Y-%m-%dT%H:%M:%S%z')]:" "$@" >&2
    dots::format::color
}

dots::warning() {
    dots::format::color "yellow"
    echo "[WARNING] [$(date +'%Y-%m-%dT%H:%M:%S%z')]:" "$@" >&2
    dots::format::color
}

dots::error() {
    dots::format::color "red"
    echo "[ERROR] [$(date +'%Y-%m-%dT%H:%M:%S%z')]:" "$@" >&2
    dots::format::color
}


# ----------------
# HELP
# ----------------
dots::help() {
    cat << EOF
Easy dotfiles presets installation

Usage: dots COMMAND [OPTIONS]

Commands:
    apply   Apply preset
    diff    Show difference between preset and local configuration

Options:
  -h        Show this help
  -v        Show detailed output
  -d HOME   Set destination folder
  -p NAME   Install preset with specific name
EOF
}


# ----------------
# PRESETS
# ----------------
dots::presets::list() {
    dots::format::color "blue"
    ls "${SCRIPT_DIR}/${PRESETS_DIR}"
    dots::format::color
}

dots::presets::apply() {
    SOURCE_PATH="${SCRIPT_DIR}/${PRESETS_DIR}/${preset}"

    if [[ -d "${SOURCE_PATH}" ]]; then
        dots::format::color "cyan"
        if [[ "${VERBOSE}" == "yes" ]]; then
            /bin/cp -v -r "${SOURCE_PATH}/." "${DEST_DIR}"
        else
            /bin/cp -r "${SOURCE_PATH}/." "${DEST_DIR}"
        fi
        dots::format::color
        dots::success "Preset \"${preset}\" applied successfully"

        dots::presets::configure
    else
        dots::error "Wrong preset name:" "${preset}"
        exit 1
    fi
}

dots::presets::configure() {
    SOURCE_PATH="${SCRIPT_DIR}/${PRESETS_DIR}/${preset}"

    if [[ -f "${SOURCE_PATH}.sh" ]]; then
        "${SOURCE_PATH}.sh"
    else
        dots::warning "Configuration script \"${SOURCE_PATH}.sh\" not found"
    fi
}


# ----------------
# COMMAND "apply"
# ----------------
dots::command::apply() {
    VERBOSE="no"
    while getopts "d:p:vh" flag; do
        case "${flag}" in
            d)
                DEST_DIR="${OPTARG}"
                shift
                ;;
            p)
                preset="${OPTARG}"
                shift
                ;;
            v)
                VERBOSE="yes"
                ;;
            h)
                dots::help
                exit 0
                ;;
            *)
                continue
                ;;
        esac
    done
    readonly VERBOSE DEST_DIR

    if [[ -n "${preset:+yes}" ]]; then
        dots::presets::apply
        exit 0
    fi

    while true; do
        echo "List of available presets: "
        dots::presets::list

        prompt="Enter name of preset to apply (or press Ctrl+C to exit): "
        read -r -p "${prompt}" preset

        dots::presets::apply

        unset preset
    done
}


# ----------------
# COMMAND 'diff'
# ----------------
dots::command::diff() {
    while getopts "d:p:h" flag; do
        case "${flag}" in
            d)
                DEST_DIR="${OPTARG}"
                shift
                ;;
            p)
                preset="${OPTARG}"
                shift
                ;;
            h)
                dots::help
                exit 0
                ;;
            *)
                continue
                ;;
        esac
    done
    readonly DEST_DIR

    if [[ -z "${preset:-}" ]]; then
        echo "List of available presets: "
        dots::presets::list

        prompt="Enter name of preset to apply (or press Ctrl+C to exit): "
        read -r -p "${prompt}" preset
    fi

    SOURCE_PATH="${SCRIPT_DIR}/${PRESETS_DIR}/${preset}"

    "${DIFF_TOOL}" "${SOURCE_PATH}" "${DEST_DIR}" &
}


# ----------------
# MAIN
# ----------------
dots::main() {
    SCRIPT_COMMAND="${1:-"no"}"
    shift
    case "${SCRIPT_COMMAND}" in
        "apply")
            dots::command::apply "$@"
            ;;
        "diff")
            dots::command::diff "$@"
            ;;
        *)
            dots::help
            exit 0
            ;;
    esac
    exit 0
}

dots::main "$@"

