#!/bin/bash

# early exit on error
set -e

_SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

_gpio() {
  "${_SCRIPT_DIR}/gpio-static" "$@"
}

_enable_4g() {
  echo "=== Enabling 4G/LTE module ==="
  
  # initialize power source switch(power_mcu, pin 34)
  # and init button(reset_mcu, pin 33)
  _gpio mode 34 out
  _gpio mode 33 out
  
  echo "Turning on power switch"

  if [ 1 == "$(_gpio read 34)" ]; then
    echo "ERR: modem is already powered on!"
    return 1
  fi

  echo "Sending power on command"
  # PWR KEY, typical 500ms
  # just like pushing the power button on a phone
  _gpio write 34 0
  _gpio write 34 1; sleep 1
  # _gpio write 34 0  # skip this command so pwrkey can indicate current module state

  # RESET KEY, emergency reset, don't have to use this
  # _gpio write 33 0
  # _gpio write 33 1 && sleep 3 && _gpio write 33 0
  
  # wait for modem
  # however not necessary, because when modem boots, modem manager will get
  # notified by kernel. blocking is not recommended and it's not always enough.
  # sleep 10
  echo "=== Finish enabling 4G/LTE module ==="
  echo "Now please wait your modem show up, you can find it with \"mmcli -L\"."
  echo "If you cannot find it for a looong time(in 30s), try to issue a manual scan with \"mmcli -S\"."
}

_enable_4g
