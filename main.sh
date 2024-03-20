#!/bin/bash

# ~~~ EaglercraftX Server
# ~~~ >> smashed together once again by ayunami2000
# ~~~ >> uwu

unset DISPLAY

echo "set -g mouse on" > ~/.tmux.conf

tmux kill-session -t server
tmux kill-session -t placeholder
killall -9 java
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
rm ./bungee/plugins/EaglercraftXBungee.jar
wget -O ./bungee/plugins/EaglercraftXBungee.jar https://www.autistici.org/eaglercraft/builds/EaglercraftX_1.8/EaglercraftX_1.8_EaglerXBungee.jar
# update waterfall!!
cd bungee
WF_VERSION="`curl -s \"https://papermc.io/api/v2/projects/waterfall\" | jq -r \".version_groups[-1]\"`"
WF_BUILDS="`curl -s \"https://papermc.io/api/v2/projects/waterfall/versions/$WF_VERSION/builds\"`"
WF_SHA256="`echo $WF_BUILDS | jq -r \".builds[-1].downloads.application.sha256\"`"
echo "$WF_SHA256 bungee.jar" | sha256sum --check
wget -O bungee-new.jar "`echo $WF_BUILDS | jq -r \".builds[-1]|\\\"https://papermc.io/api/v2/projects/waterfall/versions/$WF_VERSION/builds/\\\"+(.build|tostring)+\\\"/downloads/\\\"+.downloads.application.name\"`"
if [ -f "bungee-new.jar" ]; then
  rm bungee.jar
  mv bungee-new.jar bungee.jar
fi
cd ..
# run it!!

bash startbungee.sh
