#!/bin/bash

# ~~~ EaglercraftX Server
# ~~~ >> smashed together once again by ayunami2000
# ~~~ >> uwu

unset DISPLAY

echo "set -g mouse on" > ~/.tmux.conf

tmux kill-session -t server
tmux kill-session -t placeholder

BASEDIR="$PWD"

FORCE1="nah"

JAVA11="$(command -v javac)"
JAVA11="${JAVA11%?}"

export GIT_TERMINAL_PROMPT=0

if [ ! -d "eaglercraftx" ]; then
  rm client_version
  rm gateway_version
  FORCE1="bruh"
fi


rm -rf /tmp/##EAGLER.TEMP##
rm -rf /tmp/teavm
rm -rf /tmp/output

mkdir -p bungee/plugins

# update server
rm ../server/server.jar
cd ../server
wget -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.8.8/builds/445/downloads/paper-1.8.8-445.jar
# update waterfall!!
cd ../bungee
rm bungee-new.jar
WF_VERSION="`curl -s \"https://papermc.io/api/v2/projects/waterfall\" | jq -r \".version_groups[-1]\"`"
WF_BUILDS="`curl -s \"https://papermc.io/api/v2/projects/waterfall/versions/$WF_VERSION/builds\"`"
WF_SHA256="`echo $WF_BUILDS | jq -r \".builds[-1].downloads.application.sha256\"`"
echo "$WF_SHA256 bungee.jar" | sha256sum --check
retVal=$?
if [ $retVal -ne 0 ]; then
  wget -O bungee-new.jar "`echo $WF_BUILDS | jq -r \".builds[-1]|\\\"https://papermc.io/api/v2/projects/waterfall/versions/$WF_VERSION/builds/\\\"+(.build|tostring)+\\\"/downloads/\\\"+.downloads.application.name\"`"
  if [ -f "bungee-new.jar" ]; then
    rm bungee.jar
    mv bungee-new.jar bungee.jar
  fi
fi
cd ..

# run it!!
cd bungee
java -Xmx128M -jar bungee.jar && java -Djline.terminal=jline.UnsupportedTerminal -Xmx512M -jar ../server/server.jar nogui
done
