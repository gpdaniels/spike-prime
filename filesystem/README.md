# Filesystem #

Dumps of the micropython filesystem on the SPIKE Prime Hub using [rshell](https://github.com/dhylands/rshell).

```shell
rshell
> connect serial /dev/ttyACM0 115200
> rsync -a /pyboard ~/filesystem
```

Long version numbers are from running the `help(hub)` command on the board.
Short versions numbers are from the `version.py` files where available.
