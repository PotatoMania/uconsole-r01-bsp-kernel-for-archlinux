# Notes on running Arch on uConsole/R-01

## GNSS(GPS, etc.) and ModemManager

You can either use `modemmanager` or `gpsd` as GNSS message provider.

When using `gpsd`, you need to install a custom udev rule to notify the daemon that
the serial port come up. Besides, you need to enable the gps function with `mmcli`.

See scripts in `utilities` for more details.

## wireplumber keeping coredumped

- read logs, find libcamera related error reports
- search and find an issue: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2581
- work around it anyway:
    - `mkdir -p ~/.config/wireplumber/main.lua.d`
    - `echo 'libcamera_monitor.enabled = false' > ~/.config/wireplumber/main.lua.d/50-libcamera-config.lua`
- still need investigation

## sudo slow

Put these in your `/etc/hosts`:

```
127.0.0.1	localhost localhost.localdomain and-your-real-hostname

::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts
```
