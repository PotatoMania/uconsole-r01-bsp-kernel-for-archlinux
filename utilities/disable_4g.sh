#!/bin/bash

set -e

_SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

_gpio() {
  "${_SCRIPT_DIR}/gpio-static" "$@"
}

if [ 0 == "$(_gpio read 34)" ]; then
  echo "ERR: modem is probably not powered on!"
  return 1
fi

# a graceful shutdown, but I think it's not necessary
# unless you want to enter sleep state
_gpio mode 34 out
_gpio write 34 0
sleep 1
_gpio write 34 1
sleep 1
_gpio write 34 0

# now wait modem shutdown
