#!/bin/bash -ex

[ "$UID" = 0 ] && {
    mkdir -p ~user/Steam
    chown user: ~user/Steam
    runuser -u user "$0" "$@"
    exit 0
} || :

GAMEDIR="$HOME/Steam/steamapps/common/Rising Storm 2 - Dedicated Server/Binaries/Win64"

# install/update game
cd "$HOME"
set +e
./steamcmd.sh +@sSteamCmdForcePlatformType windows +login anonymous +app_update 418480 +quit
set -e

# start Xvfb for wine
rm -f /tmp/.X1-lock
Xvfb :1 -screen 0 800x600x24 &
export WINEDLLOVERRIDES="mscoree,mshtml="
export DISPLAY=:1

cd "$GAMEDIR"

# giving "bash" as the only parameter will drop you to a terminal here
[ "$1" = "bash" ] && exec "$@"

sh -c 'until [ "`netstat -ntl | tail -n+3`" ]; do sleep 1; done
sleep 5 # gotta wait for it to open a logfile
tail -F Logs/current.log ../Logs/*/*.log 2>/dev/null' &
/opt/wine-staging/bin/wine ./VNGame.exe -Port=7787 -QueryPort=27015 vnsu-SongBe "$@" &> logs/wine.log
