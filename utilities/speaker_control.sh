#!/bin/bash

# Params:
# $1: 1|on|ON to turn on speaker,
#     0|off|OFF to turn off speaker,
#     otherwise auto

# fail early
set -e

_SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

_gpio() {
  "${_SCRIPT_DIR}/gpio-static" "$@"
}

PIN_PA_EN=11
PIN_HEADPHONE_DETECT=10

prepare() {
    _gpio mode $PIN_PA_EN out
    _gpio mode $PIN_HEADPHONE_DETECT in
}

speaker_switch() {
    local sw=$1
    case $sw in
        1|on|ON)
            _gpio write $PIN_PA_EN 1
        ;;
        0|off|OFF)
            _gpio write $PIN_PA_EN 0
        ;;
        *)
            # auto
            if [ 0 == "$(_gpio read $PIN_HEADPHONE_DETECT)" ]
            then
                speaker_switch 1
            else
                speaker_switch 0
            fi
        ;;
    esac
}

prepare
speaker_switch "$1"
