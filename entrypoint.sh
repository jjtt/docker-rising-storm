#!/bin/bash -ex

MODE="$1"

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

  /opt/wine-staging/bin/wine ./VNGame.exe -Port=7787 -QueryPort=27015 vnsu-SongBe
  ;;
*)
  echo "Unknows mode: $MODE"
  ;;
esac
