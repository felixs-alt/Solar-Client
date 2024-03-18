cd ./server
rm ../data/trains/config.yml
rm ../data/trains/DefaultTrainProperties.yml
rm ./plugins/Essentials/userdata/*
rm ./plugins/Essentials/warps/*
mv ../data/trains/* ./plugins/Train_Carts/*
rsync -vau --remove-source-files ../data/userdata/* ./plugins/Essentials/userdata/
rsync -vau --remove-source-files ../data/warps/* ./plugins/Essentials/warps/
java -Djline.terminal=jline.UnsupportedTerminal -Xmx512M -jar server.jar nogui
rm ../data/userdata/*
rm ../data/warps/*
rm ../data/trains/savedModelModules/*
rm ../data/trains/savedTrainModules/*
rm -r ../data/trains/*
mv ./plugins/Train_Carts/* ../data/trains/*
rsync -vau --remove-source-files ./plugins/Essentials/userdata/* ../data/userdata/
rsync -vau --remove-source-files ./plugins/Essentials/warps/* ../data/warps/