#!/bin/sh

RED="tput setaf 1"
GREEN="tput setaf 2"
RESET="tput sgr0"

#This file is intented to configure a system from the begining
echo -e "\nStart System Initial Configuration\n"

echo -e "1- Download .vimrc configuration file\n"
FILE=~/.vimrc
if [ ! -f "$FILE" ]; then
    wget https://raw.githubusercontent.com/ngonkalves/dotfiles/master/home/.vimrc
    echo "$FILE was downloaded successfully."
else
    echo "$FILE is already present in the home folder."
fi

#echo "Get .vimrc file"
#[ ! -f ~/.vimrc ] && wget https://raw.githubusercontent.com/ngonkalves/dotfiles/master/home/.vimrc

echo -e "\n2- SSH Configuration\n"

ssh-keyscan github.com >> ~/.ssh/known_hosts

FILE=~/.ssh/authorized_keys
if [ ! -f "$FILE" ]; then
    echo "A new rsa pair of keys are being generated.\n"
    ssh-keygen -t rsa -C "joel.silvestre.ei@gmail.com"
    echo "{$GREEN}Public key which should be copied into github:{$RESET}\n"
    cat ~/.ssh/id_rsa.pub >> $FILE
    cat ~/.ssh/id_rsa.pub
    echo "$FILE was created successfully."
else
    echo "$FILE is already present in the home folder."
fi

echo -e "\n2- Install and configure docker\n"
sudo apt-get install docker-compose

mkdir ~/docker
mkdir ~/docker/vscode
cd ~/docker/vscode

#mkdir ~/docker/portainer
#mkdir ~/docker/wireguard
#mkdir ~/docker/nextcloud


