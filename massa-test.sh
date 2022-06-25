#!/bin/bash
echo "================================================================================"
echo -e "\033[0;35m"
echo " :::       :::   :::::::::       :::            :::::::::       ::::::::::    ";
echo " ::: +   + :::   :::     ::::    :::           ::::    :::     ::::     :::   ";
echo " :+: ++ ++ :+:   :+:     :+::+   ::+           +::      ::+    :+:            ";
echo " +:+  +:+  +:+   ++:      ++:+   +:+          :++       ++:    :+:+########   ";
echo " +#+       +#+   +++      #+++   #++          +#+       +#+    +#+      ###   ";
echo " ###       ###   ###    #####    #########     ###     ###     ###      ###   ";
echo " ###       ###   ### ######      #########       #######        ###########    ";
echo -e "\e[0m"
echo "================================================================================="

echo -e "\e[1m\e[32m1. Delete Folder Massa dan massa.sh... \e[0m" && sleep 1
#delete
rm -rf massa
rm -rf massa-test.sh

echo -e "\e[1m\e[32m2. Updating packages... \e[0m" && sleep 1
# update
sudo apt-get update
sudo apt install screen

echo -e "\e[1m\e[32m3. Installing dependencies... \e[0m" && sleep 1
# packages
sudo apt install pkg-config curl git build-essential libssl-dev libclang-dev
sudo apt-get install librocksdb-dev build-essential

echo -e "\e[1m\e[32m4. Downloading and building massa binary... \e[0m" && sleep 1
# download binary
cd $HOME
wget https://github.com/massalabs/massa/releases/download/TEST.11.3/massa_TEST.11.3_release_linux.tar.gz
tar xvzf massa_TEST.11.3_release_linux.tar.gz

echo -e "\e[1m\e[32m4. Install Node Service... \e[0m" && sleep 1
#Install Node Ke Service
echo "[Unit]
Description=Massa Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/root/massa/massa-node/run.sh
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/massad.service
mv $HOME/massad.service /etc/systemd/system/
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable massad
sudo systemctl restart massad
echo "==================================================="
