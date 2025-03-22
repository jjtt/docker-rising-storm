#!/bin/bash -ex

MODE="$1"
PORT="${2:-27015}"

case $MODE in
update)
  # install/update game
  cd "$HOME"
  set +e
  ./steamcmd.sh +@sSteamCmdForcePlatformType windows +login anonymous +app_update 418480 +quit
  set -e
  ;;
run)
  GAMEDIR="$HOME/Steam/steamapps/common/Rising Storm 2 - Dedicated Server/Binaries/Win64"

  # start Xvfb for wine
  rm -f /tmp/.X1-lock
  Xvfb :1 -screen 0 800x600x24 &
  sleep 1
  export WINEDLLOVERRIDES="mscoree,mshtml="
  export DISPLAY=:1

  cd "$GAMEDIR"

  /urs/lib/wine/wine64 ./VNGame.exe VNTE-Firebase -Port=7787 -QueryPort=$PORT $EXTRA_ARGUMENTS
  ;;
*)
  echo "Unknows mode: $MODE"
  ;;
esac
