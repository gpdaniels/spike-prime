# Filesystem #

Dumps of the micropython filesystem on the SPIKE Prime Hub using [rshell](https://github.com/dhylands/rshell).

```shell
rshell
> connect serial /dev/ttyACM0 115200
> rsync -a /pyboard ~/filesystem
```

Version numbers are from running the `help(hub)` command on the board.

