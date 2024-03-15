cd ./server
rm ./plugins/Essentials/userdata/*
rm ./plugins/Essentials/warps/*
rsync -vau --remove-source-files ../data/userdata/* ./plugins/Essentials/userdata/
rsync -vau --remove-source-files ../data/warps/* ./plugins/Essentials/warps/
java -Djline.terminal=jline.UnsupportedTerminal -Xmx512M -jar server.jar nogui
rm ../data/userdata/*
rm ../data/warps/*
rsync -vau --remove-source-files ./plugins/Essentials/userdata/* ../data/userdata/
rsync -vau --remove-source-files ./plugins/Essentials/warps/* ../data/warps/